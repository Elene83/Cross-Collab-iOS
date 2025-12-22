import SwiftUI

struct Event: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeId: Int
    let startDateTime: Date
    let endDateTime: Date
    let location: String
    let capacity: Int
    let registeredCount: Int
    let imageUrl: String?
    let isActive: Bool
    let createdById: Int
    let createdAt: Date
    let updatedAt: Date
//    let difficulty: String?
    let agenda: [EventAgenda]
    let speakers: [Speaker]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case eventTypeId
        case startDateTime
        case endDateTime
        case location
        case capacity
        case registeredCount
        case imageUrl
        case isActive
        case createdById
        case createdAt
        case updatedAt
        case agenda
        case speakers
//        case difficulty
    }
}

extension Event {
    var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return "\(formatter.string(from: startDateTime)) - \(formatter.string(from: endDateTime))"
    }
    
    var spotsRemaining: Int {
        return capacity - registeredCount
    }
}

