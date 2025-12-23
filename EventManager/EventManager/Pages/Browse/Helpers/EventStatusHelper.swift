import SwiftUI

struct EventStatusHelper {
    static func getStatusBadge(for event: EventListDto) -> (text: String, color: Color) {
        if event.isFull {
            return ("Full", .appRed)
        } else if Double(event.confirmedCount) / Double(event.capacity) > 0.8 {
            return ("Waitlist", .orange)
        } else {
            return ("Available", .appGreen)
        }
    }
}
