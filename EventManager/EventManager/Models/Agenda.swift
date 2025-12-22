import SwiftUI

struct EventAgenda: Hashable, Codable, Identifiable {
    var id: Int
    var time: Date
    var title: String
    var description: String
}
