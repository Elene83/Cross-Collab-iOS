import Foundation

protocol APIServiceProtocol {
    func getEvents(
        eventTypeId: Int?,
        location: String?,
        startDate: Date?,
        endDate: Date?,
        searchKeyword: String?,
        upcomingOnly: Bool?,
        activeOnly: Bool?,
        onlyAvailable: Bool?
    ) async throws -> [EventListDto]
    
    func getEventTypes() async throws -> [EventTypeDto]
    func getEventDetails(id: Int) async throws -> EventDetailsDto
    func getCurrentUser() async throws -> UserDto
}

extension APIServiceProtocol {
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
        try await getEvents(
            eventTypeId: eventTypeId,
            location: location,
            startDate: startDate,
            endDate: endDate,
            searchKeyword: searchKeyword,
            upcomingOnly: upcomingOnly,
            activeOnly: activeOnly,
            onlyAvailable: onlyAvailable
        )
    }
}
