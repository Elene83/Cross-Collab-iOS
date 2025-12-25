import Foundation
import SwiftUI

@MainActor
@Observable
class BrowseEventsViewModel: ErrorHandling {
    var events: [EventListDto] = []
    var eventTypes: [EventTypeDto] = []
    var isLoading = false
    var errorMessage: String?
    
    var searchText = ""
    var showFilters = false
    var selectedEventType: Int?
    
    var onlyAvailable = false
    var selectedLocation = ""
    var selectedDateRange: DateRange = .all
    var selectedEventTypeId: Int?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    var hasActiveFilters: Bool {
        onlyAvailable || !selectedLocation.isEmpty || selectedDateRange != .all || selectedEventTypeId != nil
    }
    
    var activeFiltersCount: Int {
        var count = 0
        if onlyAvailable { count += 1 }
        if !selectedLocation.isEmpty { count += 1 }
        if selectedDateRange != .all { count += 1 }
        if selectedEventTypeId != nil { count += 1 }
        return count
    }
    
    func loadInitialData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedEvents = try await apiService.getEvents()
            self.events = fetchedEvents
            
            let uniqueTypeNames = Array(Set(fetchedEvents.compactMap { $0.eventTypeName }))
            
            self.eventTypes = uniqueTypeNames.enumerated().map { index, name in
                EventTypeDto(id: index + 1, name: name, description: nil)
            }
        } catch {
            handleError(error)
        }
    }
    func refreshEvents() async {
        let dates = calculateDates(for: selectedDateRange)
        
        await loadEvents(
            eventTypeId: selectedEventType,
            searchKeyword: searchText.isEmpty ? nil : searchText,
            onlyAvailable: onlyAvailable ? true : nil,
            location: selectedLocation.isEmpty ? nil : selectedLocation,
            startDate: dates.start,
            endDate: dates.end
        )
    }
        
    func handleEventTypeSelection(_ typeId: Int?) {
        selectedEventType = typeId
        Task {
            await refreshEvents()
        }
    }
    
    func handleSearchChange(_ newValue: String) {
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await refreshEvents()
        }
    }
    
    
    func resetFilters() {
        onlyAvailable = false
        selectedLocation = ""
        selectedDateRange = .all
        selectedEventTypeId = nil
        Task { await refreshEvents() }
    }
    
    func getFilterParameters() -> EventFilterParameters {
        let dates = calculateDates(for: selectedDateRange)
        return EventFilterParameters(
            onlyAvailable: onlyAvailable ? true : nil,
            location: selectedLocation.isEmpty ? nil : selectedLocation,
            startDate: dates.start,
            endDate: dates.end,
            eventTypeId: selectedEventTypeId
        )
    }
    
    func applyFilters(_ parameters: EventFilterParameters) {
        self.onlyAvailable = parameters.onlyAvailable ?? false
        self.selectedLocation = parameters.location ?? ""
        Task {
            await refreshEvents()
        }
    }
    
    func loadEvents(
        eventTypeId: Int? = nil,
        searchKeyword: String? = nil,
        onlyAvailable: Bool? = nil,
        location: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            events = try await apiService.getEvents(
                eventTypeId: eventTypeId,
                location: location,
                startDate: startDate,
                endDate: endDate,
                searchKeyword: searchKeyword,
                onlyAvailable: onlyAvailable
            )
        } catch {
            handleError(error)
        }
    }
    
    private func calculateDates(for range: DateRange) -> (start: Date?, end: Date?) {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        
        switch range {
        case .today:
            return (startOfToday, calendar.date(byAdding: .day, value: 1, to: startOfToday))
        case .thisWeek:
            return (startOfToday, calendar.date(byAdding: .day, value: 7, to: startOfToday))
        case .thisMonth:
            return (startOfToday, calendar.date(byAdding: .month, value: 1, to: startOfToday))
        case .nextMonth:
            return (startOfToday, calendar.date(byAdding: .month, value: 2, to: startOfToday))
        case .all:
            return (nil, nil)
        }
    }
}
