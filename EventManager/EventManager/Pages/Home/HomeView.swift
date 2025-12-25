import SwiftUI

struct HomeView: View {
    @State var vm: ViewModel
    
    var body: some View {
        NavigationStack {
<<<<<<< HEAD
            ScrollView {
                VStack(spacing: 24) {
                    Header()
                    EventsTable(events: vm.events)
                    CategoryTable(categories: vm.categories, allEvents: vm.events)
                    TrendingTable(events: vm.events)
                    QuestionsTable(faqs: vm.faqs)
=======
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        Header()
                        EventsTable(events: vm.events)
                        CategoryTable(categories: vm.categories)
                        TrendingTable(events: vm.events)
                        QuestionsTable(faqs: vm.faqs)
                            .id("FAQSection")
                    }
                    .padding(.horizontal, 16)
                }
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ScrollToFAQ"))) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        proxy.scrollTo("FAQSection", anchor: .top)
                    }
>>>>>>> main
                }
            }
            .navigationDestination(for: Event.self) { event in
                DetailsView(event: event)
            }
            .navigationDestination(for: Category.self) { category in
                BrowseCategoryView(category: category, allEvents: vm.events)
            }
        }
        .task {
            await vm.fetchEvents()
        }
    }
}

#Preview {
    MainTabView()
}
