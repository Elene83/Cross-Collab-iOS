import SwiftUI

struct Category: Identifiable, Decodable {
    var id: Int
    var title: String
    var eventCount: [Event]
    var eventTypeId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case eventCount
        case eventTypeId
    }
    
    enum EventType: Int, CaseIterable {
        case teamBuilding = 1
        case sports = 2
        case workshops = 3
        case fridays = 4
        case cultural = 5
        case wellness = 6
        
        var title: String {
            switch self {
            case .teamBuilding: return "Team Building"
            case .sports: return "Sports"
            case .workshops: return "Workshops"
            case .fridays: return "Happy Fridays"
            case .cultural: return "Cultural"
            case .wellness: return "Wellness"
            }
        }
        
        var iconName: String {
            switch self {
            case .teamBuilding: return "TeamBuildingIcon"
            case .sports: return "SportsIcon"
            case .workshops: return "WorkshopsIcon"
            case .fridays: return "FridaysIcon"
            case .cultural: return "CulturalIcon"
            case .wellness: return "WellnessIcon"
            }
        }
    }
    
    var eventTypes: [EventType] {
        eventTypeId.compactMap { EventType(rawValue: $0) }
    }
    
    var iconName: String {
        eventTypes.first?.iconName ?? "DefaultIcon"
    }
}
