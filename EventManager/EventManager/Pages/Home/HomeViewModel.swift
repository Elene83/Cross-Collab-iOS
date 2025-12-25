import SwiftUI

extension HomeView {
    @Observable
    class ViewModel {
        var events: [Event] = []
        var categories: [Category] = []
        var faqs: [FAQ] = DummyFAQs.sampleFAQs
        
        var isLoading: Bool = false
        var errorMessage: String?
        
        func fetchEvents() async {
            isLoading = true
            errorMessage = nil
            
            do {
                var allEvents: [Event] = []
                var currentPage = 1
                var hasMore = true
                
                while hasMore {
                    let response: EventsResponse = try await NetworkManager.shared.getData(
                        from: "/Events",
                        queryParams: [
                            "pageSize": "100",
                            "pageNumber": String(currentPage)
                        ]
                    )
                                        
                    allEvents.append(contentsOf: response.items)
                    hasMore = response.hasNext
                    currentPage += 1
                }
                
                self.events = allEvents
                            
                generateCategories()
            } catch {
                self.errorMessage = "Failed to load events: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
        
        private func generateCategories() {
            let grouped = Dictionary(grouping: events, by: { $0.eventTypeId ?? 0 })
            
            self.categories = grouped.compactMap { (typeId, eventsInType) -> Category? in
                guard typeId != 0,
                      let eventType = Category.EventType(rawValue: typeId) else {
                    return nil
                }
                
                return Category(
                    id: eventType.rawValue,
                    title: eventType.title,
                    eventTypeId: [eventType.rawValue]
                )
            }
            .sorted { $0.title < $1.title }
        }
    }
}
