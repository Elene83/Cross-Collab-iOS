import SwiftUI

struct ApplyButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Apply", action: action)
            .fontWeight(.semibold)
            .foregroundStyle(Color.appViolet)
    }
}
