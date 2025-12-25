import Foundation
import Observation

@Observable
@MainActor
class SignInViewModel {
    var email = ""
    var password = ""
    var rememberMe = false
    var isLoading = false
    var errorMessage: String?
    var showError = false
    var isAuthenticated = false
    var showPasswordHint = false
    
    init() {
        loadRememberedEmail()
    }
    
    func loadRememberedEmail() {
        if let rememberedEmail = TokenManager.shared.getRememberedEmail() {
            email = rememberedEmail
            rememberMe = true
            checkForSavedPassword()
        }
    }
    
    func checkForSavedPassword() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        showPasswordHint = !trimmedEmail.isEmpty &&
                          TokenManager.shared.hasRememberedCredentials(for: trimmedEmail)
    }
    
    func useSavedPassword() {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        if let savedPassword = TokenManager.shared.getRememberedPassword(for: trimmedEmail) {
            password = savedPassword
            showPasswordHint = false
        }
    }
    
    func signIn() async {
        guard validateFields() else { return }
        
        isLoading = true
        errorMessage = nil
        showError = false
        
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
            
            if rememberMe {
                TokenManager.shared.saveCredentials(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password
                )
            } else {
                TokenManager.shared.clearRememberedCredentials()
            }
                        
            isLoading = false
            isAuthenticated = true
            
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
            case 400, 401, 404:
                errorMessage = "Invalid email or password"
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
    
    private func validateFields() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter your email"
            showError = true
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Please enter your password"
            showError = true
            return false
        }
        
        if !Validator.isValidEmail(email) {
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
}
