//
//  EventCardView.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventCardView: View {
    let event: EventListDto
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            DateBadgeView(dateString: event.startDateTime)
            EventDetailsColumn(event: event)
        }
        .padding(16)
        .background(Color(.appBlue.opacity(0.10))
            .cornerRadius(16))
    }
}
