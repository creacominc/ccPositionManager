
import Foundation
import AuthenticationServices

class SchwabClient
{
    internal var secrets : Secrets

    init( secrets: Secrets )
    {
        self.secrets = secrets
    }

    func authenticate(completion: @escaping (Result<URL, ErrorCodes>) -> Void)
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

    func setAccessToken(accessToken: String)
    {
        self.secrets.accessToken = accessToken

        let url = URL( string: "\(self.secrets.accessTokenUrl)" )!
        print( url )
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let authstring = "\(self.secrets.appId):\(self.secrets.appSecret)"
        let authData = authstring.data(using: .utf8)!
        let authStringEncoded = authData.base64EncodedString()
        request.setValue("Basic \(authStringEncoded)", forHTTPHeaderField: "Authorization")
        request.setValue( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type" )
        let bodyData = "grant_type=authorization_code&code=\(accessToken)&redirect_uri=\(self.secrets.redirectUrl)" // .data(using: .utf8)!
        request.httpBody = bodyData.data(using: .utf8)!
        print( "Posting access token request" )
        self.performRequest(request)
        { (result : Result< String, ErrorCodes>) in
            switch result
            {
            case .success( let tokenSet ):
                print( "token set" )
                print( tokenSet )
            case .failure(let error):
                print("Token set failed: \(error)")
                print( error.localizedDescription )
            }

        }
    }

    /**


     response = requests.post( 'https://api.schwabapi.com/v1/oauth/token', headers=headers, data=data )
     print( response.ok )
     print( response.json() )

     tokenDict = response.json()
     access_token = tokenDict['access_token']
     refresh_token = tokenDict['refresh_token']

     base_url = "https://api.schwabapi.com/trader/v1/"

     response = requests.get( f'{base_url}/accounts/accountNumbers', headers={ 'Authorization': f'Bearer {access_token}' } )

     print( response.ok )

     print( response.json() )

     */

    func setSession(session: String)
    {
        self.secrets.session = session
    }

    func getAccessToken() -> String
    {
        return self.secrets.accessToken
    }

    func getSession() -> String
    {
        return self.secrets.session
    }



    /**



     QuoteRequest{
     description:
     Request one or more quote data in POST body

     cusips    [
     example: List [ 808524680, 594918104 ]
     List of cusip, max of 500 of symbols+cusip+ssids

     [...]]
     fields    string
     example: quote,reference
     comma separated list of nodes in each quote
     possible values are quote,fundamental,reference,extended,regular. Dont send this attribute for full response.

     ssids    [
     example: List [ 1516105793, 34621523 ]
     List of Schwab securityid[SSID], max of 500 of symbols+cusip+ssids

     integer($int64)
     maximum: 9999999999
     minimum: 1]
     symbols    [
     example: List [ "MRAD", "EATOF", "EBIZ", "AAPL", "BAC", "AAAHX", "AAAIX", "$DJI", "$SPX", "MVEN", "SOBS", "TOITF", "CNSWF", "AMZN 230317C01360000", "DJX 231215C00290000", "/ESH23", "./ADUF23C0.55", "AUD/CAD" ]
     List of symbols, max of 500 of symbols+cusip+ssids

     string]
     realtime    boolean
     example: true
     Get realtime quotes and skip entitlement check

     Enum:
     [ true, false ]
     indicative    boolean
     example: true
     Include indicative symbol quotes for all ETF symbols in request. If ETF symbol ABC is in request and indicative=true API will return quotes for ABC and its corresponding indicative quote for $ABC.IV

     Enum:
     [ true, false ]
     }
     */
    func getQuotes(symbolId: String, completion: @escaping (Result<QuotesResponse, ErrorCodes>) -> Void)
    {
        /**

         */
        let urlString : String = "https://api.schwabapi.com/marketdata/v1/quotes?symbols=\(symbolId)&indicative=false"
        guard let url = URL( string: urlString ) else {
            completion( .failure( .invalidResponse ) )
            return
        }
        print( url )

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.secrets.accessToken.data(using: .utf8)?.base64EncodedString() ?? ""  )", forHTTPHeaderField: "Authorization")
        //request.setValue( "application/json", forHTTPHeaderField: "accept" )

        print( "Bearer \(self.secrets.accessToken)" )

        self.performRequest(request, completion: completion)

    }


    // {symbol_id}/quotes
    // chains (option chains)
    // expirationchains
    // pricehistory
    // movers/{symbol_id}
    // markets
    // markets/{market_id}
    // instruments
    // instruments/{cusip_id}

    // accounts/accountNumbers
    // accounts
    // accounts/{accountNumber}
    // accounts/{accountNumber}/orders - get orders
    // accounts/{accountNumber}/orders - place orders
    // accounts/{accountNumber}/orders/{orderId} - get specific order info
    // accounts/{accountNumber}/orders/{orderId} - cancel an order
    // accounts/{accountNumber}/orders/{orderId} - replace an order
    // orders - get all order
    // accounts/{accountNumber}/previewOrder

    // accounts/{accountNumber}/transactions
    // accounts/{accountNumber}/transactions/{transactionId}

    // userPreference




    
    

    
    

    
    

//    func fetchAccountData(completion: @escaping (Result<AccountData, ErrorCodes>) -> Void)
//    {
//        guard let url = URL(string: "https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/customer/accounts") else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        if let accessToken = self.accessToken
//        {
//            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//        else
//        {
//            completion(.failure(.notAuthenticated))
//            return
//        }
//        self.performRequest(request, completion: completion)
//    }

//    func fetchPositions(accountId: String, completion: @escaping (Result<[PositionData], ErrorCodes>) -> Void)
//    {
//        guard let url = URL(string: SCHWAB_POSITIONS_URI + accountId ) else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        if let accessToken = self.accessToken {
//            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//        else {
//            completion(.failure(.notAuthenticated))
//            return
//        }
//
//        self.performRequest(request, completion: completion)
//    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, ErrorCodes>) -> Void)
    {
        URLSession.shared.dataTask(with: request)
        { data, response, error in
            print( "\n\n RESPONSE:  \(response.debugDescription) \n\n" )
            print( "Data = \(String(describing: data?.base64EncodedString()))" )
            print( "Error = \(String(describing: error))" )

            if let error = error
            {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            do
            {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch
            {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}

//private struct OAuthResponse: Decodable
//{
//    let accessToken: String
//    
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "access_token"
//    }
//}
