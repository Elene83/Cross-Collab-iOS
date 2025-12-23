import SwiftUI

struct EventHeaderRow: View {
    let eventTypeName: String
    let statusBadge: (text: String, color: Color)
    
    var body: some View {
        HStack {
            Text(eventTypeName)
                .font(.caption)
                .foregroundColor(.appDarkGray)
            
            Spacer()
            
            StatusBadge(text: statusBadge.text, color: statusBadge.color)
        }
    }
}
