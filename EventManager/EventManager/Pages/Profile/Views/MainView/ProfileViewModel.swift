import Foundation
import Observation

@Observable
@MainActor
class ProfileViewModel {
    var userProfile: UserProfile?
    var isLoading = false
    var errorMessage: String?
    var showError = false
    
    init() {
        Task {
            await loadProfile()
        }
    }
    
    func loadProfile() async {
        if let userId = TokenManager.shared.getUserId(),
           let userName = TokenManager.shared.getUserName(),
           let userRole = TokenManager.shared.getUserRole() {
            
            self.userProfile = UserProfile(
                id: userId,
                fullName: userName,
                email: "",
                role: userRole
            )
        }
        
        await fetchProfileFromAPI()
    }
    
    func fetchProfileFromAPI() async {
        guard let token = TokenManager.shared.getToken() else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let profile = try await AuthService.shared.getProfile(token: token)
            self.userProfile = profile
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    func logout() {
        TokenManager.shared.clearToken()
        self.userProfile = nil
    }
}
