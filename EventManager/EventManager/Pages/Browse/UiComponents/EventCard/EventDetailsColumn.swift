import SwiftUI

struct EventDetailsColumn: View {
    let event: EventListDto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EventHeaderRow(
                eventTypeName: event.eventTypeName ?? "Unknown Type",
                statusBadge: EventStatusHelper.getStatusBadge(for: event)
            )
            
            EventTitleText(title: event.title ?? "")
            EventTimeRow(dateString: event.startDateTime)
            EventLocationRow(location: event.location ?? "No Location")
            EventRegistrationRow(event: event)
        }
    }
}
