import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private let tokenKey = "auth_token"
    private let userIdKey = "user_id"
    private let userNameKey = "user_name"
    private let userRoleKey = "user_role"
    private let expiresAtKey = "expires_at"
    
    private init() {}
    
    func saveToken(_ token: String, userId: Int, userName: String, role: String, expiresAt: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(userId, forKey: userIdKey)
        UserDefaults.standard.set(userName, forKey: userNameKey)
        UserDefaults.standard.set(role, forKey: userRoleKey)
        UserDefaults.standard.set(expiresAt, forKey: expiresAtKey)
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func getUserId() -> Int? {
        let userId = UserDefaults.standard.integer(forKey: userIdKey)
        return userId != 0 ? userId : nil
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    func getUserRole() -> String? {
        return UserDefaults.standard.string(forKey: userRoleKey)
    }
    
    func isLoggedIn() -> Bool {
        return getToken() != nil && !isTokenExpired()
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIdKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: userRoleKey)
        UserDefaults.standard.removeObject(forKey: expiresAtKey)
    }
    
    func isTokenExpired() -> Bool {
        guard let expiresAtString = UserDefaults.standard.string(forKey: expiresAtKey) else {
            return true
        }
        
        let formatter = ISO8601DateFormatter()
        guard let expiresAt = formatter.date(from: expiresAtString) else {
            return true
        }
        
        return Date() > expiresAt
    }
}
