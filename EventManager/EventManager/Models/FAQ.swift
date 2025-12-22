import SwiftUI

struct FAQ: Identifiable, Codable {
    let id: Int
    let question: String
    let answer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answer
    }
}
