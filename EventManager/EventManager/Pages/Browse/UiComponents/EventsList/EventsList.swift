import SwiftUI

struct EventsList: View {
    let events: [EventListDto]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(events) { event in
                    EventCardView(event: event)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}
