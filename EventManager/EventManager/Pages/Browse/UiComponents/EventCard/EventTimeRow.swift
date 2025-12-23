import SwiftUI

struct EventTimeRow: View {
    let dateString: String
    
    private var timeString: String {
        DateFormatter.parseTimeString(from: dateString)
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock")
                .font(.caption)
                .foregroundStyle(Color.appViolet)
            Text(timeString)
                .font(.caption)
        }
        .foregroundColor(.appDarkGray)
    }
}
