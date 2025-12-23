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
        
        do {
            try await AuthService.shared.forgotPassword(
                email: email.trimmingCharacters(in: .whitespaces)
            )
            
            isLoading = false
            showSuccess = true
            
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    private func validateEmail() -> Bool {
        if email.isEmpty {
            errorMessage = "Please enter your email"
            showError = true
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            errorMessage = "Please enter a valid email"
            showError = true
            return false
        }
        
        return true
    }
}
