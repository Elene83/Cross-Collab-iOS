import SwiftUI

struct Category: Identifiable, Decodable, Hashable {
    var id: Int
    var title: String
    var eventTypeId: [Int]
        
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case eventTypeId
    }
    
    enum EventType: Int, CaseIterable {
        case teamBuilding = 1
        case sports = 2
        case workshops = 3
        case fridays = 4
        case cultural = 5
        case wellness = 6
        case training = 7
        case social = 8
        
        var title: String {
            switch self {
            case .teamBuilding: return "Team Building"
            case .sports: return "Sports"
            case .workshops: return "Workshop"
            case .fridays: return "Happy Fridays"
            case .cultural: return "Cultural"
            case .wellness: return "Wellness"
            case .training: return "Training"
            case .social: return "Social"
            }
        }
        
        var iconName: String {
            switch self {
            case .teamBuilding: return "TeamBuildingIcon"
            case .sports: return "SportsIcon"
            case .workshops: return "WorkshopIcon"
            case .fridays: return "FridaysIcon"
            case .cultural: return "CulturalIcon"
            case .wellness: return "WellnessIcon"
            case .training: return "TrainingIcon"
            case .social: return "SocialIcon"
            }
        }
    }
    
    var eventTypes: [EventType] {
        eventTypeId.compactMap { EventType(rawValue: $0) }
    }
    
    var iconName: String {
        eventTypes.first?.iconName ?? "DefaultIcon"
    }
    
    func events(from allEvents: [Event]) -> [Event] {
        return allEvents.filter { event in
            eventTypeId.contains(event.eventTypeId ?? 0)
        }
    }
    
    func eventCount(from allEvents: [Event]) -> Int {
        return events(from: allEvents).count
    }
}
