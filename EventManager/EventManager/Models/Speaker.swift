import SwiftUI

struct Speaker: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var position: String
    var image: String
}
