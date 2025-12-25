import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.in-vent.online/api"

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formats = [
                "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                "yyyy-MM-dd'T'HH:mm:ssZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
                "yyyy-MM-dd'T'HH:mm:ss'Z'"
            ]
            
            for format in formats {
                dateFormatter.dateFormat = format
                if let date = dateFormatter.date(from: dateString) {
                    return date
                }
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date: \(dateString)")
        }
        return decoder
    }()
    
    func getData<T: Decodable>(from endpoint: String, queryParams: [String: String?]? = nil) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else { throw URLError(.badURL) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if let queryParams = queryParams {
            components?.queryItems = queryParams.compactMap { key, value in
                guard let value = value else { return nil }
                return URLQueryItem(name: key, value: value)
            }
        }
        
        guard let finalURL = components?.url else { throw URLError(.badURL) }
        let (data, response) = try await URLSession.shared.data(from: finalURL)
        
        if let httpResponse = response as? HTTPURLResponse {
            if !(200...299).contains(httpResponse.statusCode) {
                if String(data: data, encoding: .utf8) != nil {
                }
                throw URLError(.badServerResponse)
            }
        }
        
        return try decoder.decode(T.self, from: data)
    }
}
