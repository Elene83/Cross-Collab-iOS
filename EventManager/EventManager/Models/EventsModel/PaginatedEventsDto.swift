import Foundation

struct EventListDtoPagedResult: Decodable {
    let totalCount: Int
    let items: [EventListDto]?
    let pageSize: Int
    let pageNumber: Int
    let hasNext: Bool
    let hasPrevious: Bool
}

struct AnalyticsSummaryDto: Decodable {
    let totals: TotalsDto
    let topEventsByRegistrations: [TopEventByRegistrationDto]?
    let registrationsByEventType: [RegistrationsByEventTypeDto]?
    let recentActivity: [RecentActivityDto]?
}

struct TotalsDto: Decodable {
    let totalEvents: Int
    let upcomingEvents: Int
    let totalRegistrations: Int
    let totalUniqueParticipants: Int
    let averageCapacityUtilization: Double
    let totalCancellations: Int
    let cancellationRate: Double
}

struct TopEventByRegistrationDto: Decodable {
    let eventId: Int
    let eventTitle: String?
    let eventType: String?
    let registrationCount: Int
    let capacityUtilization: Double
}

struct RegistrationsByEventTypeDto: Decodable {
    let eventType: String?
    let count: Int
}

struct RecentActivityDto: Decodable {
    let timestamp: Date 
    let activityType: String?
    let eventTitle: String?
    let userName: String?
}

struct UserDto: Decodable {
    let id: Int
    let fullName: String?
    let email: String?
    let role: String?
}

struct EventFilterParameters {
    var onlyAvailable: Bool?
    var location: String?
    var startDate: Date?
    var endDate: Date?
    var eventTypeId: Int?
}

struct EventTypeDto: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"          // სერვერიდან მოდის დიდი I-თ
        case name = "Name"      // სერვერიდან მოდის დიდი N-თ
        case description = "Description"
    }
}

struct EventListDto: Codable, Identifiable {
    let id: Int
    let title: String
    let eventTypeName: String
    let startDateTime: String
    let location: String
    let capacity: Int
    let confirmedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
}

struct EventDetailsDto: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeName: String
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let confirmedCount: Int
    let waitlistedCount: Int
    let isFull: Bool
    let tags: [String]
    let createdBy: String
}

struct CreateEventRequest: Codable {
    let title: String
    let description: String?
    let eventTypeId: Int
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let tagIds: [Int]
}

struct UpdateEventRequest: Codable {
    let title: String
    let description: String?
    let eventTypeId: Int
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let tagIds: [Int]
}
