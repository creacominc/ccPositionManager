
import Foundation

public enum APIError: Error {
    case notAuthenticated
    case networkError(Error)
    case decodingError
    case invalidResponse
    case rateLimitExceeded
}
