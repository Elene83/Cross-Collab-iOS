import Foundation

protocol APIServiceProtocol {
    func getEvents(
        eventTypeId: Int?,
        location: String?,
        searchKeyword: String?,
        onlyAvailable: Bool?
    ) async throws -> [EventListDto]
    
    func getEventTypes() async throws -> [EventTypeDto]
}

