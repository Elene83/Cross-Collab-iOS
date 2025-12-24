import SwiftUI

struct EventCalendarView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let upcomingEvent = viewModel.nextUpcomingEvent {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Next Upcoming Event")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        UpcomingEventCard(event: upcomingEvent, viewModel: viewModel)
                            .padding(.horizontal)
                    }
                }
                
                CalendarGridView(viewModel: viewModel)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Events on \(viewModel.selectedDate.formatted(date: .complete, time: .omitted))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    if viewModel.eventsForSelectedDate.isEmpty {
                        Text("No events scheduled for this day")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 32)
                    } else {
                        ForEach(viewModel.eventsForSelectedDate) { event in
                            CompactEventCard(event: event, viewModel: viewModel)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
