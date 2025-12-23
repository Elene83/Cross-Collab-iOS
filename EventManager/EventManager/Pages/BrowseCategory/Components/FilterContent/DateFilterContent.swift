import SwiftUI

struct DateFilterContent: View {
    @Binding var selectedFilters: Set<String>
    
    let dateOptions = [
        ("today", "Today"),
        ("this_week", "This Week"),
        ("this_month", "This Month")
    ]
    
    var body: some View {
        List {
            ForEach(dateOptions, id: \.0) { option in
                Button(action: {
                    toggleSelection(option.0)
                }) {
                    HStack {
                        Text(option.1)
                            .foregroundStyle(Color("AppBlack"))
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if selectedFilters.contains(option.0) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color("AppBlack"))
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func toggleSelection(_ value: String) {
        if selectedFilters.contains(value) {
            selectedFilters.remove(value)
        } else {
            selectedFilters.insert(value)
        }
    }
}
