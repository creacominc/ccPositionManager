
import Foundation
import AuthenticationServices

let SCHWAB_OATH : String = "https://auth.schwab.com/oauth2/token" // https://auth.schwab.com/oauth2/token"
// https://api.schwabapi.com/marketdata/v1/quotes?symbols=mod%2Cmu&fields=quote%2Creference&indicative=false
//
let SCHWAB_ACCOUNT_URI : String = "https://api.schwabapi.com/trader/v1/accounts" // https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/customer/accounts"
let SCHWAB_POSITIONS_URI : String = "https://ausgateway.schwab.com/api/is.TradeOrderManagementWeb/v1/TradeOrderManagementWebPort/positions?accountId="

class APIClient
{
    private let clientId: String
    private let clientSecret: String
    private let redirectURI: String
    private var accessToken: String?
    private let throttler: APIThrottler

    init(clientId: String, clientSecret: String, redirectURI: String)
    {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
        self.throttler = APIThrottler(minimumInterval: 1.0)
    }

    func authenticate(completion: @escaping (Result<Void, APIError>) -> Void)
    {
        guard let url = URL(string: SCHWAB_OATH ) else {
            completion(.failure(.invalidResponse))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyParameters = [
            "grant_type": "client_credentials",
            "client_id": clientId,
            "client_secret": clientSecret,
            "redirect_uri": redirectURI
        ]
        request.httpBody = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        
        performRequest(request) { (result: Result<OAuthResponse, APIError>) in
            switch result {
            case .success(let oauthResponse):
                self.accessToken = oauthResponse.accessToken
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAccountData(completion: @escaping (Result<AccountData, APIError>) -> Void)
    {
        throttler.throttle {
            guard let url = URL(string: SCHWAB_ACCOUNT_URI) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            if let accessToken = self.accessToken {
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            else {
                completion(.failure(.notAuthenticated))
                return
            }
            
            self.performRequest(request, completion: completion)
        }
    }
    
    func fetchPositions(accountId: String, completion: @escaping (Result<[Position], APIError>) -> Void)
    {
        throttler.throttle {
            guard let url = URL(string: SCHWAB_POSITIONS_URI + accountId ) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            if let accessToken = self.accessToken {
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            else {
                completion(.failure(.notAuthenticated))
                return
            }
            
            self.performRequest(request, completion: completion)
        }
    }
    
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
