import Foundation

enum Department: Int, CaseIterable, Identifiable {
    case engineering = 1
    case marketing = 2
    case sales = 3
    case customerService = 4
    case it = 5
    case hr = 6
    
    var id: Int { rawValue }
    
    var name: String {
        switch self {
        case .engineering: return "Engineering"
        case .marketing: return "Marketing"
        case .sales: return "Sales"
        case .customerService: return "Customer Service"
        case .it: return "IT"
        case .hr: return "HR"
        }
    }
    
    static func from(id: Int) -> Department? {
        return Department(rawValue: id)
    }
}
