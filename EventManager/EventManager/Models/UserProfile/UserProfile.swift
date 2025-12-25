struct UserProfile: Codable {
    let id: Int
    let fullName: String
    let email: String
    let role: String
    
    static var mock: UserProfile {
        UserProfile(
            id: 1,
            fullName: "John Doe",
            email: "john.doe@example.com",
            role: "User"
        )
    }
}
