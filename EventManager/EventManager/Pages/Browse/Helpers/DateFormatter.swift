import Foundation

extension DateFormatter {
    static func parseDateComponents(from dateString: String) -> (month: String, day: String) {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else {
            return ("JAN", "01")
        }
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        return (
            monthFormatter.string(from: date).uppercased(),
            dayFormatter.string(from: date)
        )
    }
    
    static func parseTimeString(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else {
            return "Time TBD"
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: date)
    }
}
