
import Foundation
import AuthenticationServices

let SCHWAB_OATH : String = "https://api.schwabapi.com/v1/oauth/token" // https://auth.schwab.com/oauth2/token"
// https://api.schwabapi.com/marketdata/v1/quotes?symbols=mod%2Cmu&fields=quote%2Creference&indicative=false
//
let SCHWAB_ACCOUNT_URI : String = "https://api.schwabapi.com/trader/v1/accounts" // https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/customer/accounts"
let SCHWAB_POSITIONS_URI : String = "https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/positions?accountId="

class APIClient
{
    private var secrets: Secrets = Secrets( AUTORIZE_WEB: "" , clientId: "" , redirectUrl: "" )
    private var accessToken: String = ""

    init()
    {

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(".secrets.json")

        let data = try? Data( contentsOf: fileURL )
        
        do {
            self.secrets = try JSONDecoder().decode( Secrets.self, from: data!)
            print( "secrets: \( self.secrets )" )
        } catch {
            print("Error decoding JSON: \(error)")
        }

    }

    func authenticate(completion: @escaping (Result<URL, APIError>) -> Void)
    {
        // provide the URL for authentication.
        let AUTHORIZE_URL : String  = "\(self.secrets.AUTORIZE_WEB)?response_type=code&client_id=\(self.secrets.clientId)&scope=readonly&redirect_uri=\(self.secrets.redirectUrl)"
        guard let url = URL( string: AUTHORIZE_URL ) else {
            completion(.failure(.invalidResponse))
            return
        }
        completion( .success( url ) )
        return
    }

//        guard let url = URL(string: SCHWAB_OATH ) else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        
//        let bodyParameters = [
//            "grant_type": "client_credentials",
//            "client_id": clientId,
//            "client_secret": clientSecret,
//            "redirect_uri": redirectURI
//        ]
//        request.httpBody = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
//        
//        performRequest(request) { (result: Result<OAuthResponse, APIError>) in
//            switch result {
//            case .success(let oauthResponse):
//                self.accessToken = oauthResponse.accessToken
//                completion(.success(()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }


//    func fetchAccountData(completion: @escaping (Result<AccountData, APIError>) -> Void)
//    {
//
//        guard let url = URL(string: "https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/customer/accounts") else {
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
//
//    }
//    
//    func fetchPositions(accountId: String, completion: @escaping (Result<[PositionData], APIError>) -> Void)
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
    
    private func performRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void)
    {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}

private struct OAuthResponse: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
