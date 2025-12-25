import SwiftUI

struct BrowseCategoryView: View {
    let category: Category
    let allEvents: [Event] 
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFilters: Set<String> = []
    
    var categoryEvents: [Event] {
        category.events(from: allEvents)
    }
    
    var filteredEvents: [Event] {
        categoryEvents.filtered(by: selectedFilters)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image("leftArrow")
                    }
                    
                    Spacer()
                    
                    Text(category.title)
                        .font(.system(size: 20))
                        .foregroundStyle(Color("AppBlack"))
                    
                    Spacer()
                    
                    Image("leftArrow")
                        .opacity(0)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                CategoryFilter(selectedFilters: $selectedFilters, events: categoryEvents)
                
                if filteredEvents.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 48))
                            .foregroundStyle(.gray.opacity(0.5))
                        
                        Text(selectedFilters.isEmpty ? "No events available" : "No events match your filters")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                } else {
                    VStack(spacing: 16) {
                        ForEach(filteredEvents) { event in
                            NavigationLink(value: event) {
                                CategoryEventCard(event: event)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer(minLength: 24)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView()
}
