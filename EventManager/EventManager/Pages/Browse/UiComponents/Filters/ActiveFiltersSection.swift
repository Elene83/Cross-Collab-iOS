import SwiftUI

struct ActiveFiltersSection: View {
    let activeFiltersCount: Int
    
    var body: some View {
        Section {
            HStack {
                Text("Active Filters")
                    .foregroundColor(.appDarkGray)
                Spacer()
                Text("\(activeFiltersCount)")
                    .fontWeight(.semibold)
                    .foregroundColor(.appBlue)
            }
        }
    }
}
