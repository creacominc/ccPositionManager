
import Foundation
import AuthenticationServices

/**
   SchwabClient - interaction with Schwab web site.
    Members:
        - secrets : a Secrets object with the configuration for this connection.
    Methods:
        - getAuthenticationUrl : Executes the completion with the URL for logging into and authenticating the connection.
        - getAccessToken : given the URL returned by the authentication process, extract the code and get the access token.
 */
class SchwabClient
{
    internal var secrets : Secrets

    init( secrets: Secrets )
    {
        self.secrets = secrets
    }

    /**
     * getAuthenticationUrl : Executes the completion with the URL for logging into and authenticating the connection.
     */
    func getAuthenticationUrl(completion: @escaping (Result<URL, ErrorCodes>) -> Void)
    {
        // provide the URL for authentication.
        let AUTHORIZE_URL : String  = "\(self.secrets.authorizationUrl)?client_id=\(self.secrets.appId)&redirect_uri=\(self.secrets.redirectUrl)"
        guard let url = URL( string: AUTHORIZE_URL ) else {
            completion(.failure(.invalidResponse))
            return
        }
        completion( .success( url ) )
        return
    }

    /**
     * getAccessToken : given the URL returned by the authentication process, extract the code and get the access token.
     */
    func getAccessToken( from url: String, completion: @escaping (Result<Void, ErrorCodes>) -> Void )
    {
        // extract the code and session from the URL
        let urlComponents = URLComponents(string: url )!
        let queryItems = urlComponents.queryItems

        self.secrets.code = queryItems?.first(where: { $0.name == "code" })?.value ?? ""
        self.secrets.session = queryItems?.first(where: { $0.name == "session" })?.value ?? ""

//        print( "code: \(self.secrets.code)" )
//        print( "session: \(self.secrets.session)" )

        // Access Token Request
        let url = URL( string: "\(self.secrets.accessTokenUrl)" )!
//        print( "accessTokenUrl: \(url)" )
        var accessTokenRequest = URLRequest( url: url )
        accessTokenRequest.httpMethod = "POST"
        // headers
        let authStringEncoded = String("\(self.secrets.appId):\(self.secrets.appSecret)").data(using: .utf8)!.base64EncodedString()
        accessTokenRequest.setValue( "Basic \(authStringEncoded)", forHTTPHeaderField: "Authorization" )
        accessTokenRequest.setValue( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        // body
        accessTokenRequest.httpBody = String("grant_type=authorization_code&code=\(self.secrets.code)&redirect_uri=\(self.secrets.redirectUrl)").data(using: .utf8)!
        print( "Posting access token request:  \(accessTokenRequest)" )

        URLSession.shared.dataTask(with: accessTokenRequest)
        { data, response, error in
            guard let data = data, error == nil else {
                print( "Error: \( error?.localizedDescription ?? "Unknown error" )" )
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            {
                if let tokenDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                {
                    self.secrets.accessToken = tokenDict["access_token"] as? String ?? ""
                    self.secrets.refreshToken = tokenDict["refresh_token"] as? String ?? ""
//                    print( "AccessToken = \(self.secrets.accessToken)" )
//                    print( "RefreshToken = \(self.secrets.refreshToken)" )
                    self.fetchAccountNumbers()
                } else {
                    print( "Failed to parse token response" )
                }
            } else {
                print( "Failed to get token" )
            }
        }.resume()


    }


    func fetchAccountNumbers()
    {
        guard !self.secrets.accessToken.isEmpty else { return }
        print( "In fetchAccountNumbers" )
        var request = URLRequest(url: URL(string: "https://api.schwabapi.com/trader/v1/accounts/accountNumbers")!)
        request.setValue("Bearer \(self.secrets.accessToken)", forHTTPHeaderField: "Authorization")
//        print( "AccessToken: \(self.secrets.accessToken)" )
        URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else
            {
                print( "error: \(String(describing: error))" )
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            {
                do
                {
                    print( "status code == 200" )
                    print( "type of data: \(type(of: data))" )
                    print( "Error: \(String(describing: error))" )

                    let decoder = JSONDecoder()
                    do
                    {
                        let accountNumbers = try decoder.decode([SchwabAccounts].self, from: data)
                        print( "Account Number: \(accountNumbers[0].accountNumber.suffix( 5 ))" )
//                        print( "Hash: \(accountNumbers[0].hashValue)" )
                        print( "Account Number: \(accountNumbers[1].accountNumber.suffix( 5 ))" )
//                        print( "Hash: \(accountNumbers[1].hashValue)" )
                        DispatchQueue.main.async
                        {
                            self.secrets.accountNumbers = [accountNumbers[0].accountNumber, accountNumbers[1].accountNumber]
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
/**
 let data = Data(str.utf8)
 print( data )

 let decoder = JSONDecoder()
 do
 {
     let account = try decoder.decode([AccountData2].self, from: data)
     print( account )
 }
 catch
 {
     print( error.localizedDescription )
 }

 */

                }
//                catch
//                {
//                    print( "error: \(error.localizedDescription)" )
//                }

//                if let accountDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                   let accounts = accountDict["accounts"] as? [String]
//                {
//                    DispatchQueue.main.async {
//                        self.secrets.accountNumbers = accounts
//                    }
//                }
//                else
//                {
//                    print( "Failed to parse account response" )
//                }
            }
            else
            {
                print( "Failed to fetch account numbers" )
            }
            
        }.resume()
    }

    struct SchwabAccounts: Decodable
    {
        var accountNumber: String
        var hashValue: String
    }
    
}

