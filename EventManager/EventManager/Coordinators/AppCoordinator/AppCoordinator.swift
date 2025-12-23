import SwiftUI

@MainActor
class AppCoordinator: ObservableObject {
    @Published var isAuthenticated = false
    
    init() {
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        isAuthenticated = TokenManager.shared.isLoggedIn()
    }
    
    func login() {
        isAuthenticated = true
    }
    
    func logout() {
        TokenManager.shared.clearToken()
        isAuthenticated = false
    }
}
