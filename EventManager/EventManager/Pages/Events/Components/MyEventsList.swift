import SwiftUI

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
