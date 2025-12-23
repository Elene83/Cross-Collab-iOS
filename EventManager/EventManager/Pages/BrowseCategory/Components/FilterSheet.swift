import SwiftUI

struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    let filterType: FilterType
    let events: [Event]
    @Binding var selectedFilters: Set<String>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                switch filterType {
                case .location:
                    LocationFilterContent(events: events, selectedFilters: $selectedFilters)
                case .date:
                    DateFilterContent(selectedFilters: $selectedFilters)
                case .spots:
                    SpotsFilterContent(selectedFilters: $selectedFilters)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        clearFilters()
                    }
                    .foregroundStyle(Color("AppGray"))
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .navigationViewStyle(.stack)
    }
    
    private var navigationTitle: String {
        switch filterType {
        case .location: return "Location"
        case .date: return "Date"
        case .spots: return "Available Spots"
        }
    }
    
    private func clearFilters() {
        switch filterType {
        case .location:
            let locations = Set(events.map { $0.location })
            selectedFilters.subtract(locations)
        case .date:
            selectedFilters.subtract(["today", "this_week", "this_month"])
        case .spots:
            selectedFilters.subtract(["spots_1+", "spots_5+", "spots_10+", "spots_20+"])
        }
    }
}
