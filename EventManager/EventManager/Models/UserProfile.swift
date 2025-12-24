import Foundation

struct UserProfile {
    let id: Int
    let fullName: String
    let email: String
    let department: String
    let profileImageUrl: String?
    
    static let mock = UserProfile(
        id: 1,
        fullName: "Elene Dgebuadze",
        email: "Elene.Dgebuadze@.com",
        department: "Software Development",
        profileImageUrl: nil
    )
}
