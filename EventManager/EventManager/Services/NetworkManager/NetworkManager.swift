import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://35.205.108.13:5001/"
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
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
        
        guard let url = components?.url else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}
