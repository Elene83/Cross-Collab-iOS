import SwiftUI

struct EventCalendarView: View {
    let events: [Event]
    @Binding var selectedDate: Date
    
    var nextUpcomingEvent: Event? {
        events
            .filter { $0.startDateTime > Date() }
            .sorted { $0.startDateTime < $1.startDateTime }
            .first
    }
    
    var eventsForSelectedDate: [Event] {
        events.filter { Calendar.current.isDate($0.startDateTime, inSameDayAs: selectedDate) }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Next Upcoming Event
                if let upcomingEvent = nextUpcomingEvent {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Next Upcoming Event")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        UpcomingEventCard(event: upcomingEvent)
                            .padding(.horizontal)
                    }
                }
                
                // Calendar
                CalendarGridView(events: events, selectedDate: $selectedDate)
                    .padding(.horizontal)
                
                // Events for Selected Date
                VStack(alignment: .leading, spacing: 12) {
                    Text("Events on \(selectedDate.formatted(date: .complete, time: .omitted))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if eventsForSelectedDate.isEmpty {
                        Text("No events scheduled for this day")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 32)
                    } else {
                        ForEach(eventsForSelectedDate) { event in
                            CompactEventCard(event: event)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
