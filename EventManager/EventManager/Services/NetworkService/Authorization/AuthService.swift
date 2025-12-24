import Foundation

@MainActor
class AuthService {
    static let shared = AuthService()
    
    private let baseURL = "http://35.205.108.13:5001/api"
    
    private init() {}
    
    // MARK: - Login
    func login(email: String, password: String) async throws -> AuthResponse {
        // 1. დარწმუნდი, რომ baseURL-ს ბოლოში არ აქვს ზედმეტი /
        let urlString = "\(baseURL)/Auth/login"
        guard let url = URL(string: urlString) else { throw AuthError.invalidResponse }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 2. დაამატე ეს ორივე ჰედერი აუცილებლად
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // 3. მონაცემების გასუფთავება (ზედმეტი Space-ების მოცილება)
        let body = LoginRequest(
            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
            password: password
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        print("DEBUG: Final URL: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        print("DEBUG: Server Response Code: \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200 else {
            // თუ აქ მოვიდა 404, სცადე urlString-ში "Auth" პატარა ასოთი "auth"
            throw AuthError.serverError(statusCode: httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(AuthResponse.self, from: data)
    }
    
    // MARK: - Register
    func register(
        email: String,
        password: String,
        fullName: String
    ) async throws -> AuthResponse {
        let url = URL(string: "\(baseURL)/Auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = RegisterRequest(
            email: email,
            password: password,
            fullName: fullName
        )
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw AuthError.serverError(statusCode: httpResponse.statusCode)
        }
        
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        return authResponse
    }
    
    // MARK: - Forgot Password
    func forgotPassword(email: String) async throws {
        // სცადე ეს სრული მისამართი
        let url = URL(string: "http://35.205.108.13:5001/api/Auth/forgot-password")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // აქ დაბეჭდე პასუხი, რომ ვნახოთ რას ამბობს სერვერი
        if let str = String(data: data, encoding: .utf8) {
            print("DEBUG: Server Response: \(str)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            print("DEBUG: Failed with status code: \(code)")
            throw AuthError.serverError(statusCode: code)
        }
    }
    
    // MARK: - Get Profile (from /api/Auth/me)
    func getProfile(token: String) async throws -> UserProfile {
        let url = URL(string: "\(baseURL)/Auth/me")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw AuthError.serverError(statusCode: httpResponse.statusCode)
        }
        
        let profile = try JSONDecoder().decode(UserProfile.self, from: data)
        return profile
    }
}

// MARK: - Auth Errors
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
            case 401:
                return "Invalid email or password"
            case 400:
                return "Invalid request. Please check your input"
            case 409:
                return "User already exists"
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

