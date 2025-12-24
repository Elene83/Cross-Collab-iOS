import Foundation

enum Validator {
    static func isValidEmail(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        guard !trimmedEmail.isEmpty else { return false }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: trimmedEmail)
    }
    
    static func isValidEmailStrict(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedEmail.isEmpty else { return false }
        
        let components = trimmedEmail.split(separator: "@")
        guard components.count == 2 else { return false }
        
        let localPart = String(components[0])
        let domainPart = String(components[1])
        
        guard !localPart.isEmpty else { return false }
        guard localPart.count >= 1 && localPart.count <= 64 else { return false }
        guard !localPart.hasPrefix(".") && !localPart.hasSuffix(".") else { return false }
        guard !localPart.contains("..") else { return false }
        
        let localPartRegex = "^[A-Za-z0-9._-]+$"
        guard NSPredicate(format:"SELF MATCHES %@", localPartRegex).evaluate(with: localPart) else {
            return false
        }
        
        guard !domainPart.isEmpty else { return false }
        guard !domainPart.hasPrefix(".") && !domainPart.hasSuffix(".") else { return false }
        guard !domainPart.hasPrefix("-") && !domainPart.hasSuffix("-") else { return false }
        guard !domainPart.contains("..") else { return false }
        
        let domainComponents = domainPart.split(separator: ".")
        guard domainComponents.count >= 2 else { return false }
        
        for component in domainComponents {
            if component.isEmpty { return false }
            if component.hasPrefix("-") || component.hasSuffix("-") { return false }
        }
        
        let domainRegex = "^[A-Za-z0-9.-]+$"
        guard NSPredicate(format:"SELF MATCHES %@", domainRegex).evaluate(with: domainPart) else {
            return false
        }
        
        guard let tld = domainComponents.last else { return false }
        guard tld.count >= 2 && tld.count <= 24 else { return false }
        
        let tldRegex = "^[A-Za-z]+$"
        guard NSPredicate(format:"SELF MATCHES %@", tldRegex).evaluate(with: String(tld)) else {
            return false
        }
        
        return true
    }
}
