import SwiftUI

extension DetailsView {
    @Observable
    class ViewModel {
        var registeredEventIds: Set<Int> = []
        var waitlistedEventIds: Set<Int> = []
        var registrationIds: [Int: Int] = [:]
        var isLoading: Bool = false
        var currentEvent: Event?
        var errorMessage: String?
        
        private let apiService = APIService.shared
        
        func isRegistered(for event: Event) -> Bool {
            return registeredEventIds.contains(event.id)
        }
        
        func isWaitlisted(for event: Event) -> Bool {
            return waitlistedEventIds.contains(event.id)
        }
        
        func buttonText(for event: Event) -> String {
            if isRegistered(for: event) {
                return "Registered"
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
                return Color("AppGreen")
            } else if isWaitlisted(for: event) {
                return Color.orange
            } else {
                return Color("AppViolet")
            }
        }
        
        func handleRegistration(for event: Event) async {
            isLoading = true
            errorMessage = nil
            
            guard let userId = TokenManager.shared.getUserId() else {
                errorMessage = "Please log in to register"
                isLoading = false
                return
            }
            
            do {
                if isRegistered(for: event) || isWaitlisted(for: event) {
                    guard let registrationId = registrationIds[event.id] else {
                        throw NSError(domain: "Registration", code: -1, userInfo: [NSLocalizedDescriptionKey: "Registration ID not found"])
                    }
                    
                    try await apiService.unregisterFromEvent(registrationId: registrationId)
                    
                    registeredEventIds.remove(event.id)
                    waitlistedEventIds.remove(event.id)
                    registrationIds.removeValue(forKey: event.id)
                    
                } else if event.spotsRemaining > 0 {
                    try await apiService.registerForEvent(eventId: event.id, userId: userId)
                    registeredEventIds.insert(event.id)
                    
                    await loadRegistrationStatus(for: event)
                } else {
                    try await apiService.registerForEvent(eventId: event.id, userId: userId)
                    waitlistedEventIds.insert(event.id)
                    
                    await loadRegistrationStatus(for: event)
                }
            } catch {
                errorMessage = "Registration failed: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
        
        func loadRegistrationStatus(for event: Event) async {
            guard let userId = TokenManager.shared.getUserId() else { return }
            
            do {
                let myRegistrations = try await apiService.getMyRegistrations(userId: userId)
                
                if let registration = myRegistrations.first(where: { $0.eventId == event.id }) {
                    registrationIds[event.id] = registration.registrationId
                    
                    if registration.status == "Confirmed" {
                        registeredEventIds.insert(event.id)
                    } else if registration.status == "Waitlisted" {
                        waitlistedEventIds.insert(event.id)
                    }
                }
            } catch {
                print("Could not load registration status: \(error)")
            }
        }
    }
}
