import SwiftUI

struct HomeView: View {
    @State var vm: ViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Header()
                    EventsTable(events: vm.events)
                    CategoryTable(categories: vm.categories)
                    TrendingTable(events: vm.events)
                    QuestionsTable(faqs: vm.faqs)
                }
                .padding(.horizontal, 16)
            }
            .navigationDestination(for: Event.self) { event in
                DetailsView(event: event)
            }
            .navigationDestination(for: Category.self) { category in
                BrowseCategoryView(category: category)
            }
        }
    }
}

#Preview {
    MainTabView()
}
