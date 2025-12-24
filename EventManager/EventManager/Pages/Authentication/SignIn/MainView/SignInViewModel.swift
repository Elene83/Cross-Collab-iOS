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
    var isAuthenticated = false
    
    func signIn() async {
        guard validateFields() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let authResponse = try await AuthService.shared.login(
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
                TokenManager.shared.saveToken(
                authResponse.token,
                userId: authResponse.userId,
                userName: authResponse.fullName,
                role: authResponse.role,
                expiresAt: authResponse.expiresAt
            )
            
            print("DEBUG: Login successful. Token saved for user: \(authResponse.fullName)")
            
            isLoading = false
            isAuthenticated = true 
            
        } catch {
            isLoading = false
            handleBackendError(error)
        }
    }
    
    private func handleBackendError(_ error: Error) {
        if let authError = error as? AuthError {
            self.errorMessage = authError.errorDescription
        } else {
            self.errorMessage = error.localizedDescription
        }
        self.showError = true
    }
    
    private func validateFields() -> Bool {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields"
            showError = true
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            errorMessage = "Please enter a valid email address"
            showError = true
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters long"
            showError = true
            return false
        }
        
        return true
    }
}
