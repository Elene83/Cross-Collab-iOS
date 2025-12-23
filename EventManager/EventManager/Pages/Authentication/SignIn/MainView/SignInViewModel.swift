import Foundation
import Observation

@Observable
@MainActor
class SignInViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showError = false
    
    func signIn() async {
        guard validateInput() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await AuthService.shared.login(
                email: email.trimmingCharacters(in: .whitespaces),
                password: password
            )
            
            TokenManager.shared.saveToken(
                response.token,
                userId: response.userId,
                userName: response.fullName,
                role: response.role
            )
            
            isLoading = false
            
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    private func validateInput() -> Bool {
        if email.isEmpty {
            errorMessage = "Please enter your email"
            showError = true
            return false
        }
        
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email"
            showError = true
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Please enter your password"
            showError = true
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
