import Foundation
import Observation

@Observable
@MainActor
class RegistrationViewModel {
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var agreedToTerms = false
    var isLoading = false
    var errorMessage: String?
    var showError = false
    var phoneNumber = ""
    var otpCode: [String] = Array(repeating: "", count: 6)
    var selectedDepartmentId: Int = 0
    
    func register() async -> Bool {
        guard validateInput() else { return false }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fullName = "\(firstName) \(lastName)"
            let response = try await AuthService.shared.register(
                email: email.trimmingCharacters(in: .whitespaces),
                password: password,
                fullName: fullName
            )
            
            TokenManager.shared.saveToken(
                response.token,
                userId: response.userId,
                userName: response.fullName,
                role: response.role,
                expiresAt: response.expiresAt
            )
            
            isLoading = false
            return true
            
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            showError = true
            return false
        }
    }
    
    private func validateInput() -> Bool {
        if firstName.isEmpty || lastName.isEmpty {
            errorMessage = "Please enter your full name"
            showError = true
            return false
        }
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email"
            showError = true
            return false
        }
        if password.count < 6 { 
            errorMessage = "Password must be at least 6 characters"
            showError = true
            return false
        }
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showError = true
            return false
        }
        if !agreedToTerms {
            errorMessage = "Please agree to Terms of Service"
            showError = true
            return false
        }
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
