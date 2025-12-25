import SwiftUI
import MapKit
import Combine

@MainActor
class MyEventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedView: Int = 0
    @Published var selectedDate: Date = Date()
    @Published var currentMonth: Date = Date()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var nextUpcomingEvent: Event? {
        events
            .filter { $0.startDateTime > Date() }
            .sorted { $0.startDateTime < $1.startDateTime }
            .first
    }
    
    var eventsForSelectedDate: [Event] {
        events.filter { Calendar.current.isDate($0.startDateTime, inSameDayAs: selectedDate) }
    }
    
    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    var daysInMonth: [Date?] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: currentMonth),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }
        
        var days: [Date?] = []
        var currentDate = monthFirstWeek.start
        
        while days.count < 42 {
            if Calendar.current.isDate(currentDate, equalTo: currentMonth, toGranularity: .month) {
                days.append(currentDate)
            } else {
                days.append(nil)
            }
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return days
    }
    
    init() {
        Task {
            await loadEvents()
        }
    }
    
    func loadEvents() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: EventsResponse = try await NetworkManager.shared.getData(from: "api/events")
            self.events = response.items
        } catch {
            self.errorMessage = "Failed to load events: \(error.localizedDescription)"
            print("Error fetching events: \(error)")
        }
        
        isLoading = false
    }
    
    func hasEvents(for date: Date) -> Bool {
        events.contains { Calendar.current.isDate($0.startDateTime, inSameDayAs: date) }
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
    }
    
    func geocodeLocation(for location: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
    
    func formatEventDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func formatEventTime(_ date: Date) -> String {
        date.formatted(date: .omitted, time: .shortened)
    }
    
    func formatEventDateTime(_ startDateTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return formatter.string(from: startDateTime)
    }
    
    func getEventTypeName(for typeId: Int) -> String {
        Category.EventType(rawValue: typeId)?.title ?? "Event"
    }
}

#Preview {
    MainTabView()
}
