import SwiftUI
import MapKit

// MARK: - Main Events View
struct MyEventsView: View {
    @State private var selectedView = 0
    @State private var selectedDate = Date()
    
    let events = DummyEvents.sampleEvents
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 16) {
                Text("My Events")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Segmented Picker
                Picker("View", selection: $selectedView) {
                    Text("List").tag(0)
                    Text("Calendar").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.2)),
                alignment: .bottom
            )
            
            // Content
            if selectedView == 0 {
                EventListView(events: events)
            } else {
                EventCalendarView(events: events, selectedDate: $selectedDate)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - List View
struct EventListView: View {
    let events: [Event]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(events) { event in
                    EventCard(event: event)
                }
            }
            .padding()
        }
    }
}

struct MyEventCard2: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text("\(event.startDateTime.formatted(date: .abbreviated, time: .omitted)), \(event.startDateTime.formatted(date: .omitted, time: .shortened)) - \(event.endDateTime.formatted(date: .omitted, time: .shortened))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "mappin.circle")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text(event.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "person.2")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text("\(event.registeredCount)/\(event.capacity) registered")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(Category.EventType(rawValue: event.eventTypeId)?.title ?? "Event")
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.1))
                .foregroundColor(.primary)
                .cornerRadius(12)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Calendar View
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

// MARK: - Upcoming Event Card with Map
struct UpcomingEventCard: View {
    let event: Event
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                    .frame(width: 16)
                Text("\(event.startDateTime.formatted(date: .abbreviated, time: .omitted)), \(event.startDateTime.formatted(date: .omitted, time: .shortened)) - \(event.endDateTime.formatted(date: .omitted, time: .shortened))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
                Image(systemName: "mappin.circle")
                    .foregroundColor(.gray)
                    .frame(width: 16)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Map using UIViewRepresentable
            MapViewRepresentable(region: $region)
                .frame(height: 120)
                .cornerRadius(8)
                .overlay(
                    Text("Map Preview of Event Location")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                )
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
    }
}

// MARK: - MapKit Integration with UIViewRepresentable
struct MapViewRepresentable: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.isUserInteractionEnabled = false
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - Calendar Grid
struct CalendarGridView: View {
    let events: [Event]
    @Binding var selectedDate: Date
    
    @State private var currentMonth = Date()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekDays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
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
    
    func hasEvents(for date: Date) -> Bool {
        events.contains { Calendar.current.isDate($0.startDateTime, inSameDayAs: date) }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Month navigation
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
                
                Text(monthYearString)
                    .font(.headline)
                
                Spacer()
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            // Weekday headers
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            // Calendar days
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        DayCell(
                            date: date,
                            isToday: Calendar.current.isDateInToday(date),
                            isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                            hasEvents: hasEvents(for: date)
                        )
                        .onTapGesture {
                            selectedDate = date
                        }
                    } else {
                        Text("")
                            .frame(height: 36)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}

struct DayCell: View {
    let date: Date
    let isToday: Bool
    let isSelected: Bool
    let hasEvents: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.subheadline)
                .foregroundColor(isToday ? .white : .primary)
                .frame(width: 36, height: 36)
                .background(isToday ? Color.blue : Color.clear)
                .clipShape(Circle())
            
            if hasEvents && !isToday {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

// MARK: - Compact Event Card
struct CompactEventCard: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(event.startDateTime.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.caption)
                    Text(Category.EventType(rawValue: event.eventTypeId)?.title ?? "Event")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle")
                        .font(.caption)
                    Text(event.location)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(8)
    }
}

// Note: Using Category.EventType from your existing struct
// The Category struct with EventType enum should be imported/available

// MARK: - Preview
#Preview {
    MyEventsView()
}
