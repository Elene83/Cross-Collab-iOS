import Foundation
import Observation

@Observable
@MainActor
class RegistrationViewModel {
    var firstName = ""
    var lastName = ""
    var email = ""
    var phoneNumber = ""
    var otpCode = ["", "", "", "", "", ""]
    var selectedDepartmentId = 0
    var password = ""
    var confirmPassword = ""
    var agreedToTerms = false
    var isLoading = false
    var errorMessage: String?
    var showError = false
    
    func register() async {
        guard validateInput() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let fullName = "\(firstName) \(lastName)"
            let response = try await AuthService.shared.register(
                email: email.trimmingCharacters(in: .whitespaces),
                password: password,
                fullName: fullName,
                phoneNumber: phoneNumber,
                departmentId: selectedDepartmentId
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
        if firstName.isEmpty || lastName.isEmpty {
            errorMessage = "Please enter your full name"
            showError = true
            return false
        }
        
        if email.isEmpty || !isValidEmail(email) {
            errorMessage = "Please enter a valid email"
            showError = true
            return false
        }
        
        if password.count < 8 {
            errorMessage = "Password must be at least 8 characters"
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
        
        if selectedDepartmentId == 0 {
            errorMessage = "Please select a department"
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
