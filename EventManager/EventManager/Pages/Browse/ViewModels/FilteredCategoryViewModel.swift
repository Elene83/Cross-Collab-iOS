import Foundation
import SwiftUI

@MainActor
@Observable
class FilteredCategoryViewModel: ErrorHandling {
    var events: [EventListDto] = []
    var isLoading = false
    var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func loadEvents(eventTypeId: Int) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            events = try await apiService.getEvents(
                eventTypeId: eventTypeId,
                location: nil,
                startDate: nil,
                endDate: nil,
                searchKeyword: nil,
                upcomingOnly: nil,
                activeOnly: nil,
                onlyAvailable: nil
            )
        } catch {
            handleError(error)
        }
    }
}
