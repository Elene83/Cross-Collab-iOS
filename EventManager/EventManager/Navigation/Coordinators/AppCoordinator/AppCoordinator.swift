import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var selectedTab: Int = 0 
    
    init() {
        self.isAuthenticated = TokenManager.shared.isLoggedIn()
    }
    
    func login() {
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }
    
    func logout() {
        TokenManager.shared.clearToken()
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
