import Foundation

struct UserProfileDto: Codable, Identifiable {
    let id: Int
    let email: String
    let fullName: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName
        case role
    }
}
