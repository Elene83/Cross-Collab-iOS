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
        
        var queryParams: [String: String?] = [
            "EventTypeId": eventTypeId.map { String($0) },
            "Location": location,
            "SearchKeyword": searchKeyword,
            "UpcomingOnly": upcomingOnly.map { String($0) },
            "ActiveOnly": activeOnly.map { String($0) },
            "OnlyAvailable": onlyAvailable.map { String($0) }
        ]
        
        let formatter = ISO8601DateFormatter()
        if let startDate = startDate { queryParams["StartDate"] = formatter.string(from: startDate) }
        if let endDate = endDate { queryParams["EndDate"] = formatter.string(from: endDate) }

        do {
            let response: EventListDtoPagedResult = try await network.getData(from: "/Events", queryParams: queryParams)
            return response.items ?? []
        } catch {
            throw error
        }
    }
    
    func getEventTypes() async throws -> [EventTypeDto] {
        return []
    }
    
    func getEventDetails(id: Int) async throws -> EventDetailsDto {
        return try await network.getData(from: "/Events/\(id)")
    }
    
    func getCurrentUser() async throws -> UserDto {
        return try await network.getData(from: "/Auth/me")
    }
    
    func registerForEvent(eventId: Int, userId: Int) async throws {
          let body = [
              "eventId": eventId,
              "userId": userId
          ]
          
          try await network.postData(to: "/Registrations", body: body)
      }
    
    func getMyRegistrations(userId: Int) async throws -> [UserRegistrationDto] {
        return try await network.getData(from: "/Registrations/user/\(userId)")
    }
    
    func unregisterFromEvent(registrationId: Int) async throws {
        try await network.deleteData(from: "/Registrations/\(registrationId)")
    }
    
  }

