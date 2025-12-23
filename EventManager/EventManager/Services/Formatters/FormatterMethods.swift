import SwiftUI

class Formatters {
    static let shared = Formatters()
    
    private init() {}
    
    func monthAbbreviation(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: event.startDateTime).uppercased()
    }
    
    func dayOfMonth(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: event.startDateTime)
    }
    
    func timeRange(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let start = formatter.string(from: event.startDateTime)
        let end = formatter.string(from: event.endDateTime)
        return "\(start) - \(end)"
    }
    
    func formatStartDate(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy • h:mm a"
        return formatter.string(from: event.startDateTime)
    }
    
    func formatStartDateMonth(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: event.startDateTime)
    }
    
    func formattedDateCard(for event: Event) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter.string(from: event.startDateTime)
    }
}
