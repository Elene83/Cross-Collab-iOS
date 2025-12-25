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
        showSuccess = false
        
        do {
            try await AuthService.shared.forgotPassword(
                email: email.trimmingCharacters(in: .whitespaces)
            )
            
            isLoading = false
            showSuccess = true
            
        } catch let error as AuthError {
            isLoading = false
            handleAuthError(error)
        } catch {
            isLoading = false
            errorMessage = "An error occurred. Please try again"
            showError = true
        }
    }
    
    private func handleAuthError(_ error: AuthError) {
        switch error {
        case .invalidResponse:
            errorMessage = "Invalid server response"
        case .serverError(let statusCode):
            switch statusCode {
            case 400:
                errorMessage = "Invalid email address"
            case 404:
                errorMessage = "This email is not registered"
            case 429:
                errorMessage = "Too many attempts. Please try again later"
            case 500...599:
                errorMessage = "Server error. Please try again later"
            default:
                errorMessage = "Error occurred (Code: \(statusCode))"
            }
        case .decodingError:
            errorMessage = "Error processing data"
        case .networkError:
            errorMessage = "Network connection error"
        }
        showError = true
    }
    
    private func validateEmail() -> Bool {
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your email"
            showError = true
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email.trimmingCharacters(in: .whitespaces)) {
            errorMessage = "Please enter a valid email address"
            showError = true
            return false
        }
        
        return true
    }
    
    func clearError() {
        errorMessage = nil
        showError = false
    }
    
    func clearSuccess() {
        showSuccess = false
    }
}
