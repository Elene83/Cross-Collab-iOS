import SwiftUI

struct SpotsFilterContent: View {
    @Binding var selectedFilters: Set<String>
    
    let spotOptions = [
        ("spots_1+", "1+ spots available"),
        ("spots_5+", "5+ spots available"),
        ("spots_10+", "10+ spots available"),
        ("spots_20+", "20+ spots available")
    ]
    
    var body: some View {
        List {
            ForEach(spotOptions, id: \.0) { option in
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
