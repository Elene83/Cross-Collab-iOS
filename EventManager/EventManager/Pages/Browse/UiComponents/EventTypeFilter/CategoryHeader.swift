import SwiftUI

struct CategoryHeader: View {
    let eventType: EventTypeDto
    
    var body: some View {
        VStack(spacing: 8) {
            Text(eventType.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.appDarkGray)
            
            if let description = eventType.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.appDarkGray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
