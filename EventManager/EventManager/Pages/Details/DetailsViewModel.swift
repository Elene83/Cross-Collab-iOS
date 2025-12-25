import SwiftUI

extension DetailsView {
    @Observable
    class ViewModel {
        var events = DummyEvents.sampleEvents
        var categories: [Category] = DummyCategories.sampleCategories
        var faqs: [FAQ] = DummyFAQs.sampleFAQs
        
        var registeredEventIds: Set<Int> = []
        var waitlistedEventIds: Set<Int> = []
        var isLoading: Bool = false
        
        func isRegistered(for event: Event) -> Bool {
            return registeredEventIds.contains(event.id)
        }
        
        func isWaitlisted(for event: Event) -> Bool {
            return waitlistedEventIds.contains(event.id)
        }
        
        func buttonText(for event: Event) -> String {
            if isRegistered(for: event) {
                return "Registered ✓"
            } else if isWaitlisted(for: event) {
                return "Waitlisted"
            } else if event.spotsRemaining > 0 {
                return "Register Now"
            } else {
                return "Join Waitlist"
            }
        }
        
        func buttonColor(for event: Event) -> Color {
            if isRegistered(for: event) {
                return Color.green
            } else if isWaitlisted(for: event) {
                return Color.orange
            } else {
                return Color("AppViolet")
            }
        }
        
        func handleRegistration(for event: Event) {
            isLoading = true
            
            //async simulation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self = self else { return }
                
                if self.isRegistered(for: event) {
                    self.registeredEventIds.remove(event.id)
                    print("Unregistered from event: \(event.title)")
                } else if self.isWaitlisted(for: event) {
                    self.waitlistedEventIds.remove(event.id)
                    print("Removed from waitlist: \(event.title)")
                } else if event.spotsRemaining > 0 {
                    self.registeredEventIds.insert(event.id)
                    print("Registered for event: \(event.title)")
                } else {
                    self.waitlistedEventIds.insert(event.id)
                    print("Joined waitlist: \(event.title)")
                }
                
                self.isLoading = false
            }
        }
    }
}

