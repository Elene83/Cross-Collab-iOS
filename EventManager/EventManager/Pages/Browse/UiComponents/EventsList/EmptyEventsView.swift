import SwiftUI

struct EmptyEventsView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 12) {
                Image(systemName: "calendar.badge.exclamationmark")
                    .font(.system(size: 50))
                    .foregroundColor(.appViolet)
                
                Text("No events found")
                    .font(.headline)
                    .foregroundColor(.appRed)
            }
            Spacer()
        }
    }
}
