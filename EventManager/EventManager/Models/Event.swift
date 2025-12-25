import SwiftUI

struct Event: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeId: Int?
    let eventTypeName: String
    let startDateTime: Date
    let location: String
    let capacity: Int
    let isActive: Bool?
    let confirmedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
    
    let agenda: [EventAgenda]?
    let speakers: [Speaker]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case eventTypeId
        case eventTypeName
        case startDateTime
        case location
        case capacity
        case isActive
        case confirmedCount
        case isFull
        case imageUrl
        case tags
        case agenda
        case speakers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        eventTypeId = try container.decodeIfPresent(Int.self, forKey: .eventTypeId)
        eventTypeName = try container.decode(String.self, forKey: .eventTypeName)
        startDateTime = try container.decode(Date.self, forKey: .startDateTime)
        location = try container.decode(String.self, forKey: .location)
        capacity = try container.decode(Int.self, forKey: .capacity)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)  
        confirmedCount = try container.decode(Int.self, forKey: .confirmedCount)
        isFull = try container.decode(Bool.self, forKey: .isFull)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
        
        agenda = try container.decodeIfPresent([EventAgenda].self, forKey: .agenda)
        speakers = try container.decodeIfPresent([Speaker].self, forKey: .speakers)
    }
}

extension Event {
    var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: startDateTime)
    }
    
    var spotsRemaining: Int {
        return capacity - confirmedCount
    }
    
    var registeredCount: Int {
        return confirmedCount
    }
}

struct EventsResponse: Codable {
    let totalCount: Int
    let items: [Event]
    let pageSize: Int
    let pageNumber: Int
    let hasNext: Bool
    let hasPrevious: Bool
}
