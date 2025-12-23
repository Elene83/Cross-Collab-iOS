import SwiftUI

struct LocationFilterContent: View {
    let events: [Event]
    @Binding var selectedFilters: Set<String>
    
    var uniqueLocations: [String] {
        Array(Set(events.map { $0.location })).sorted()
    }
    
    var body: some View {
        List {
            ForEach(uniqueLocations, id: \.self) { location in
                Button(action: {
                    toggleSelection(location)
                }) {
                    HStack {
                        Text(location)
                            .foregroundStyle(Color("AppBlack"))
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if selectedFilters.contains(location) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color("AppBlack"))
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func toggleSelection(_ location: String) {
        if selectedFilters.contains(location) {
            selectedFilters.remove(location)
        } else {
            selectedFilters.insert(location)
        }
    }
}
