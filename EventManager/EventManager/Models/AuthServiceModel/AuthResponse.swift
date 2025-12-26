import Foundation

struct AuthResponse: Codable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
    let departmentId: Int?  
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId
        case fullName
        case role
        case departmentId
        case expiresAt
    }
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let email: String
    let phoneNumber: String
    let password: String
    let fullName: String
    let departmentId: Int
}

struct ForgotPasswordRequest: Codable {
    let email: String
}

struct LoginResponse: Codable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
    let departmentId: Int?
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId
        case fullName
        case role
        case departmentId  
        case expiresAt
    }
}


