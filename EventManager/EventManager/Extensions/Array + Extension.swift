import SwiftUI

extension Array where Element == Event {
    func filtered(by selectedFilters: Set<String>) -> [Event] {
        guard !selectedFilters.isEmpty else { return self }
        
        return self.filter { event in
            var matchesFilter = true
            
            let locationFilters = selectedFilters.filter { filter in
                !["today", "this_week", "this_month", "spots_1+", "spots_5+", "spots_10+", "spots_20+"].contains(filter)
            }
            
            if !locationFilters.isEmpty {
                matchesFilter = matchesFilter && locationFilters.contains(event.location)
            }
            
            if selectedFilters.contains("today") {
                matchesFilter = matchesFilter && Calendar.current.isDateInToday(event.startDateTime)
            }
            
            if selectedFilters.contains("this_week") {
                matchesFilter = matchesFilter && Calendar.current.isDate(event.startDateTime, equalTo: Date(), toGranularity: .weekOfYear)
            }
            
            if selectedFilters.contains("this_month") {
                matchesFilter = matchesFilter && Calendar.current.isDate(event.startDateTime, equalTo: Date(), toGranularity: .month)
            }
            
            if selectedFilters.contains("spots_1+") {
                matchesFilter = matchesFilter && event.spotsRemaining >= 1
            }
            
            if selectedFilters.contains("spots_5+") {
                matchesFilter = matchesFilter && event.spotsRemaining >= 5
            }
            
            if selectedFilters.contains("spots_10+") {
                matchesFilter = matchesFilter && event.spotsRemaining >= 10
            }
            
            if selectedFilters.contains("spots_20+") {
                matchesFilter = matchesFilter && event.spotsRemaining >= 20
            }
            
            return matchesFilter
        }
    }
}
