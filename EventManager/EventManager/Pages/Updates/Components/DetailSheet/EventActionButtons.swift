import SwiftUI

struct EventActionButtons: View {
    var body: some View {
        VStack(spacing: 12) {
            ActionButton(
                icon: "questionmark.circle",
                title: "Send a question about the event",
                action: {}
            )
            
            ActionButton(
                icon: "calendar.badge.plus",
                title: "Add to my calendar",
                action: {}
            )
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    UpdatesView()
}
