//
//  EventDetailsColumn.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventDetailsColumn: View {
    let event: EventListDto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EventHeaderRow(
                eventTypeName: event.eventTypeName,
                statusBadge: EventStatusHelper.getStatusBadge(for: event)
            )
            
            EventTitleText(title: event.title)
            EventTimeRow(dateString: event.startDateTime)
            EventLocationRow(location: event.location)
            EventRegistrationRow(event: event)
        }
    }
}
