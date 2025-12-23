import Foundation

struct EventCapacityHelper {
    static func calculateSpotsLeft(for event: EventListDto) -> Int {
        return event.capacity - event.confirmedCount
    }
}
