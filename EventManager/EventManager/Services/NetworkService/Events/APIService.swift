import Foundation

class APIService: APIServiceProtocol {
    static let shared = APIService()
    private let network = NetworkManager.shared
    
    private init() {}
    
    func getEvents(
        eventTypeId: Int? = nil,
        location: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        searchKeyword: String? = nil,
        upcomingOnly: Bool? = nil,
        activeOnly: Bool? = nil,
        onlyAvailable: Bool? = nil
    ) async throws -> [EventListDto] {
        
        var queryParams: [String: String?] = [:]
        let formatter = ISO8601DateFormatter()
        
        if let eventTypeId = eventTypeId { queryParams["EventTypeId"] = "\(eventTypeId)" }
        if let location = location, !location.isEmpty { queryParams["Location"] = location }
        if let searchKeyword = searchKeyword, !searchKeyword.isEmpty { queryParams["SearchKeyword"] = searchKeyword }
        
        // თარიღების ფორმატირება სერვერისთვის
        if let startDate = startDate { queryParams["StartDate"] = formatter.string(from: startDate) }
        if let endDate = endDate { queryParams["EndDate"] = formatter.string(from: endDate) }
        
        if let onlyAvailable = onlyAvailable { queryParams["OnlyAvailable"] = "\(onlyAvailable)" }
        
        let response: EventListDtoPagedResult = try await network.getData(from: "api/Events", queryParams: queryParams)
        return response.items ?? []
    }
    
    func getEventTypes() async throws -> [EventTypeDto] {
        // რადგან 404-ს აბრუნებს, დავაბრუნოთ ცარიელი, რომ ივენთებიდან შეივსოს
        return []
    }
    
    func getEventDetails(id: Int) async throws -> EventDetailsDto {
        return try await network.getData(from: "api/Events/\(id)")
    }
    
    func getCurrentUser() async throws -> UserDto {
        return try await network.getData(from: "api/Auth/me")
    }
}
