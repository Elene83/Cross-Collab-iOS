import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let fullName: String
    let phoneNumber: String
    let departmentId: Int
}

struct LoginResponse: Codable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
    let expiresAt: String
}

struct AuthError: Codable {
    let message: String
    let errorCode: String
    let statusCode: Int
}

class AuthService {
    static let shared = AuthService()
    
    // Mock Mode ყოველთვის true-ზეა ჯერჯერობით
    private let useMockData = true
    
    func login(email: String, password: String) async throws -> LoginResponse {
        guard !email.isEmpty else {
            throw NetworkError.serverError("Please enter your email")
        }
        
        guard !password.isEmpty else {
            throw NetworkError.serverError("Please enter your password")
        }
        
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return LoginResponse(
            token: "mock_jwt_token_\(UUID().uuidString)",
            userId: 1,
            fullName: "John Doe",
            role: "Employee",
            expiresAt: ISO8601DateFormatter().string(from: Date().addingTimeInterval(86400))
        )
    }
    
    func register(email: String, password: String, fullName: String,
                  phoneNumber: String, departmentId: Int) async throws -> LoginResponse {
        
        guard !email.isEmpty else {
            throw NetworkError.serverError("Please enter your email")
        }
        
        guard !password.isEmpty else {
            throw NetworkError.serverError("Please enter your password")
        }
        
        guard !fullName.isEmpty else {
            throw NetworkError.serverError("Please enter your full name")
        }
        
        guard departmentId > 0 else {
            throw NetworkError.serverError("Please select a department")
        }
        
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return LoginResponse(
            token: "mock_jwt_token_\(UUID().uuidString)",
            userId: Int.random(in: 100...999),
            fullName: fullName,
            role: "Employee",
            expiresAt: ISO8601DateFormatter().string(from: Date().addingTimeInterval(86400))
        )
    }
    
    func forgotPassword(email: String) async throws {
        guard !email.isEmpty else {
            throw NetworkError.serverError("Please enter your email")
        }
        
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return
    }
}

enum NetworkError: LocalizedError {
    case invalidResponse
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response"
        case .serverError(let message):
            return message
        }
    }
}
