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
        loadProfile()
    }
    
    func loadProfile() {
        // Mock data - ბექენდის მოლოდინში
        userProfile = UserProfile.mock
    }
    
    func logout() {
        TokenManager.shared.clearToken()
    }
}
