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
                let response: EventsResponse = try await NetworkManager.shared.getData(from: "api/events")
                self.events = response.items
                            
                generateCategories()
            } catch {
                self.errorMessage = "Failed to load events: \(error.localizedDescription)"
                print("Error fetching events: \(error)")
            }
            
            isLoading = false
        }
        
        private func generateCategories() {
            let grouped = Dictionary(grouping: events, by: { $0.eventTypeName })
            self.categories = grouped.map { (typeName, eventsInType) -> Category in
                let eventType = Category.EventType.allCases.first { $0.title == typeName }
                                
                return Category(
                    id: eventType?.rawValue ?? typeName.hashValue,
                    title: typeName,
                    eventTypeId: eventType.map { [$0.rawValue] } ?? []
                )
            }
            .sorted { $0.title < $1.title }
        }
    }
}
