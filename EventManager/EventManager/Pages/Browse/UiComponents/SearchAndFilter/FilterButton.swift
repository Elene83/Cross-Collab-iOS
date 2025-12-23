import SwiftUI

struct FilterButton: View {
    @Binding var showFilters: Bool
    
    var body: some View {
        Button(action: { showFilters.toggle() }) {
            HStack(spacing: 6) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(Color(.appViolet))
                Text("Filters")
            }
            .foregroundColor(.appDarkGray)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.white))
            .cornerRadius(12)
        }
    }
}
