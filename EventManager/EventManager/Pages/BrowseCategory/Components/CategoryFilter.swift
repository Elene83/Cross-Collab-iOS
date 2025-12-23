import SwiftUI

struct CategoryFilter: View {
    @Binding var selectedFilters: Set<String>
    let events: [Event]
    
    @State private var showingLocationSheet = false
    @State private var showingDateSheet = false
    @State private var showingSpotsSheet = false
    
    let filters: [CategoryFilterModel] = [
        CategoryFilterModel(isActive: false, label: "Location", type: .location),
        CategoryFilterModel(isActive: false, label: "Date", type: .date),
        CategoryFilterModel(isActive: false, label: "Available Spots", type: .spots)
    ]
    
    var hasActiveFilters: Bool {
        !selectedFilters.isEmpty
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                Button(action: {
                    if hasActiveFilters {
                        selectedFilters.removeAll()
                    }
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 14))
                        
                        Text("Filter")
                            .font(.system(size: 14))
                    }
                    .foregroundStyle(hasActiveFilters ? .white : Color("AppDarkGray"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(hasActiveFilters ? Color("AppBlack") : Color("AppLightGray").opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                
                ForEach(filters) { filter in
                    CategoryFilterItem(
                        filterItem: CategoryFilterModel(
                            isActive: isFilterActive(filter.type),
                            label: filter.label,
                            type: filter.type
                        )
                    )
                    .onTapGesture {
                        switch filter.type {
                        case .location:
                            showingLocationSheet = true
                        case .date:
                            showingDateSheet = true
                        case .spots:
                            showingSpotsSheet = true
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .sheet(isPresented: $showingLocationSheet) {
            FilterSheet(
                filterType: .location,
                events: events,
                selectedFilters: $selectedFilters
            )
        }
        .sheet(isPresented: $showingDateSheet) {
            FilterSheet(
                filterType: .date,
                events: events,
                selectedFilters: $selectedFilters
            )
        }
        .sheet(isPresented: $showingSpotsSheet) {
            FilterSheet(
                filterType: .spots,
                events: events,
                selectedFilters: $selectedFilters
            )
        }
    }
    
    private func isFilterActive(_ type: FilterType) -> Bool {
        switch type {
        case .location:
            let locations = Set(events.map { $0.location })
            return !selectedFilters.intersection(locations).isEmpty
        case .date:
            return selectedFilters.contains("today") ||
                   selectedFilters.contains("this_week") ||
                   selectedFilters.contains("this_month")
        case .spots:
            return selectedFilters.contains("spots_1+") ||
                   selectedFilters.contains("spots_5+") ||
                   selectedFilters.contains("spots_10+") ||
                   selectedFilters.contains("spots_20+")
        }
    }
}
