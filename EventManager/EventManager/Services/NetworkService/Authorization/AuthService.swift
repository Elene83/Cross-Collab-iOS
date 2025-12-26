import Foundation

@MainActor
class AuthService {
    static let shared = AuthService()
    
    private let baseURL = "https://api.in-vent.online/api"
    
    private init() {}
    
    func login(email: String, password: String) async throws -> AuthResponse {
        let urlString = "\(baseURL)/Auth/login"
        guard let url = URL(string: urlString) else {
            throw AuthError.invalidResponse
        }
        
        let body = LoginRequest(
            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
            password: password
        )
        
        return try await performRequest(url: url, method: "POST", body: body)
    }
    
    func register(
        email: String,
        password: String,
        fullName: String,
        phoneNumber: String,
        departmentId: Int
    ) async throws -> AuthResponse {
        let urlString = "\(baseURL)/Auth/register"
        guard let url = URL(string: urlString) else {
            throw AuthError.invalidResponse
        }
        
        let body = RegisterRequest(
            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
            phoneNumber: phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines),
            password: password,
            fullName: fullName.trimmingCharacters(in: .whitespacesAndNewlines),
            departmentId: departmentId
        )
        
        return try await performRequest(url: url, method: "POST", body: body)
    }
    
    func forgotPassword(email: String) async throws {
        let urlString = "\(baseURL)/Auth/forgot-password"
        guard let url = URL(string: urlString) else {
            throw AuthError.invalidResponse
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        request.httpBody = try? JSONEncoder().encode(trimmedEmail)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AuthError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw AuthError.serverError(statusCode: httpResponse.statusCode)
            }
        } catch let error as AuthError {
            throw error
        } catch {
            throw AuthError.networkError
        }
    }
   
    func getDepartments() async throws -> [Department] {
        let urlString = "\(baseURL)/Auth/departments"
        guard let url = URL(string: urlString) else { throw AuthError.invalidResponse }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AuthError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)
        }
        
        return try JSONDecoder().decode([Department].self, from: data)
    }
    
    func getProfile(token: String) async throws -> UserProfileDto {
        let urlString = "\(baseURL)/Auth/me"
        guard let url = URL(string: urlString) else {
            throw AuthError.invalidResponse
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AuthError.invalidResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                throw AuthError.serverError(statusCode: httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(UserProfileDto.self, from: data)
            
        } catch let error as AuthError {
            throw error
        } catch is DecodingError {
            throw AuthError.decodingError
        } catch {
            throw AuthError.networkError
        }
    }
    
    private func performRequest<T: Encodable, R: Decodable>(
        url: URL,
        method: String,
        body: T
    ) async throws -> R {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 30
        do {
            request.httpBody = try JSONEncoder().encode(body)
            if String(data: request.httpBody!, encoding: .utf8) != nil {
            }
        } catch {
            throw AuthError.decodingError
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AuthError.invalidResponse
            }
            if String(data: data, encoding: .utf8) != nil {
            }
            
            guard httpResponse.statusCode == 200 else {
                throw AuthError.serverError(statusCode: httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(R.self, from: data)
            
        } catch let error as AuthError {
            throw error
        } catch is DecodingError {
            throw AuthError.decodingError
        } catch {
            throw AuthError.networkError
        }
    }
    
 
}
