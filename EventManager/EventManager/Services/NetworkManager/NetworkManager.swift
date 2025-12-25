import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://35.205.108.13:5001/"
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            if let date = dateFormatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string: \(dateString)")
        }
        
        return decoder
    }()
    
    func getData<T: Decodable>(from endpoint: String, queryParams: [String: String?]? = nil) async throws -> T {
        var components = URLComponents(string: baseURL + endpoint)
        
        if let queryParams = queryParams {
            components?.queryItems = queryParams.compactMap { key, value in
                guard let value = value else { return nil }
                return URLQueryItem(name: key, value: value)
            }
        }
<<<<<<< HEAD
        let (data, _) = try await URLSession.shared.data(from: url)
=======
        
        guard let url = components?.url else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
>>>>>>> main
        
        return try decoder.decode(T.self, from: data)
    }
}
