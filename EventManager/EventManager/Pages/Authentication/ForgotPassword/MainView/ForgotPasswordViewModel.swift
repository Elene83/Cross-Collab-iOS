import Foundation
import Observation

@Observable
@MainActor
class ForgotPasswordViewModel {
    var email = ""
    var isLoading = false
    var errorMessage: String?
    var showError = false
    var showSuccess = false
    
    func sendResetLink() async {
        guard validateEmail() else { return }
        
        isLoading = true
        errorMessage = nil
        showError = false
        
        do {
            try await AuthService.shared.forgotPassword(email: email)
            isLoading = false
            showSuccess = true
        } catch {
            isLoading = false
            errorMessage = "This feature is temporarily unavailable."
            showError = true
        }
    }
    
    func clearError() {
        errorMessage = nil
        showError = false
    }
    
    private func validateEmail() -> Bool {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && trimmed.contains("@")
    }
}
