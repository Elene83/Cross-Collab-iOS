import Foundation

struct AuthResponse: Codable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
    let expiresAt: String
    
    var expirationDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: expiresAt)
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let email: String
    let password: String
    let fullName: String
}

struct ForgotPasswordRequest: Codable {
    let email: String
}
