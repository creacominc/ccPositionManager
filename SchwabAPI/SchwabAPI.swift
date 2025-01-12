
import Foundation

public class SchwabAPI {
    private let apiClient: APIClient
    
    public init(clientId: String, clientSecret: String, redirectURI: String) {
        self.apiClient = APIClient(clientId: clientId, clientSecret: clientSecret, redirectURI: redirectURI)
    }
    
    public func authenticate(completion: @escaping (Result<Void, APIError>) -> Void) {
        apiClient.authenticate(completion: completion)
    }
    
    public func fetchAccountData(completion: @escaping (Result<AccountData, APIError>) -> Void) {
        apiClient.fetchAccountData(completion: completion)
    }
    
    public func fetchPositions(accountId: String, completion: @escaping (Result<[Position], APIError>) -> Void) {
        apiClient.fetchPositions(accountId: accountId, completion: completion)
    }
}
