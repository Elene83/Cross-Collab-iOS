import SwiftUI

struct EventTitleText: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.appDarkGray)
            .lineLimit(2)
    }
}
