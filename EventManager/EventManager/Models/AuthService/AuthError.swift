import Foundation

enum AuthError: LocalizedError {
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .serverError(let statusCode):
            switch statusCode {
            case 400:
                return "Invalid request. Please check your input"
            case 401:
                return "Invalid email or password"
            case 403:
                return "Access forbidden"
            case 404:
                return "Resource not found"
            case 409:
                return "User already exists"
            case 429:
                return "Too many requests. Please try again later"
            case 500...599:
                return "Server error. Please try again later"
            default:
                return "Error occurred (Code: \(statusCode))"
            }
        case .decodingError:
            return "Error processing server response"
        case .networkError:
            return "Network error. Please check your connection"
        }
    }
}
