import SwiftUI

enum FilterType: Identifiable {
    case location
    case date
    case spots
    
    var id: String {
        switch self {
        case .location: return "location"
        case .date: return "date"
        case .spots: return "spots"
        }
    }
}

struct CategoryFilterModel: Identifiable {
    var id: String { label }
    var isActive: Bool
    var label: String
    var type: FilterType
}
