import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Close")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appDarkGray)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .padding(.horizontal, 24)
    }
}
