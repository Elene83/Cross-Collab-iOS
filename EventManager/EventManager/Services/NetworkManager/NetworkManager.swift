import SwiftUI

final class NetworkManager {
    //MARK: Properties
    static let shared = NetworkManager()
    private let baseURL = "http://35.205.108.13:5001/"
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    //MARK: Methods
    func getData<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(T.self, from: data)
    }
}
