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
    var departments: [Department] = []
    
    func register() async -> Bool {
        guard validateInput() else { return false }
        
        isLoading = true
        errorMessage = nil
        showError = false
        
        do {
            let fullName = "\(firstName.trimmingCharacters(in: .whitespaces)) \(lastName.trimmingCharacters(in: .whitespaces))"
            let response = try await AuthService.shared.register(
                email: email.trimmingCharacters(in: .whitespaces),
                password: password,
                fullName: fullName,
                phoneNumber: phoneNumber.trimmingCharacters(in: .whitespaces),
                departmentId: selectedDepartmentId
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
            
        } catch let error as AuthError {
            isLoading = false
            handleAuthError(error)
            return false
        } catch {
            isLoading = false
            errorMessage = "An error occurred. Please try again"
            showError = true
            return false
        }
    }
    
    private func handleAuthError(_ error: AuthError) {
        switch error {
        case .invalidResponse:
            errorMessage = "Invalid server response"
        case .serverError(let statusCode):
            switch statusCode {
            case 400:
                errorMessage = "Invalid data. Please check your input"
            case 409:
                errorMessage = "This email is already registered"
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
    func fetchDepartments() async {
            do {
                self.departments = try await AuthService.shared.getDepartments()
            } catch {
            }
        }
    
    private func validateInput() -> Bool {
        if firstName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your first name"
            showError = true
            return false
        }
        
        if firstName.trimmingCharacters(in: .whitespaces).count < 2 {
            errorMessage = "First name must be at least 2 characters"
            showError = true
            return false
        }
        
        if lastName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your last name"
            showError = true
            return false
        }
        
        if lastName.trimmingCharacters(in: .whitespaces).count < 2 {
            errorMessage = "Last name must be at least 2 characters"
            showError = true
            return false
        }
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your email"
            showError = true
            return false
        }
        
        if !Validator.isValidEmailStrict(email) {
            errorMessage = "Please enter a valid email address"
            showError = true
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Please enter a password"
            showError = true
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters"
            showError = true
            return false
        }
        
        if password.count > 50 {
            errorMessage = "Password is too long (maximum 50 characters)"
            showError = true
            return false
        }
        
        if confirmPassword.isEmpty {
            errorMessage = "Please confirm your password"
            showError = true
            return false
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showError = true
            return false
        }
        
        if !agreedToTerms {
            errorMessage = "Please agree to the Terms of Service"
            showError = true
            return false
        }
        
        if phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your phone number"
            showError = true
            return false
        }
        
        if phoneNumber.trimmingCharacters(in: .whitespaces).count < 9 {
            errorMessage = "Please enter a valid phone number"
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
    
    func clearError() {
        errorMessage = nil
        showError = false
    }
}
