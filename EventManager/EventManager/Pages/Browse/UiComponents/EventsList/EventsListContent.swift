//
//  EventsListContent.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventsListContent: View {
    let isLoading: Bool
    let events: [EventListDto]
    let errorMessage: String?
    let retryAction: () -> Void
    
    var body: some View {
        Group {
            if let error = errorMessage {
                ErrorView(errorMessage: error, retryAction: retryAction)
            } else if isLoading && events.isEmpty {
                LoadingView()
            } else if events.isEmpty {
                EmptyEventsView()
            } else {
                EventsList(events: events)
            }
        }
    }
}
