//
//  BrowseEventsViewModel.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import Foundation
import SwiftUI

@MainActor
class BrowseEventsViewModel: ObservableObject, ErrorHandling {
    // MARK: Events Properties
    @Published var events: [EventListDto] = []
    @Published var eventTypes: [EventTypeDto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: Search & Filter Properties
    @Published var searchText = ""
    @Published var showFilters = false
    @Published var selectedEventType: Int?
    
    // MARK: Filter Properties
    @Published var onlyAvailable = false
    @Published var selectedLocation = ""
    @Published var selectedDateRange: DateRange = .all
    @Published var selectedEventTypeId: Int?
    
    private let apiService: APIServiceProtocol
    private var searchTask: Task<Void, Never>?
    
    init(apiService: APIServiceProtocol = MockAPIService.shared) {
        self.apiService = apiService
    }
    
    deinit {
           searchTask?.cancel()
       }
    
    // MARK: Computed Properties
    var hasActiveFilters: Bool {
        onlyAvailable ||
        !selectedLocation.isEmpty ||
        selectedDateRange != .all ||
        selectedEventTypeId != nil
    }
    
    var activeFiltersCount: Int {
        var count = 0
        if onlyAvailable { count += 1 }
        if !selectedLocation.isEmpty { count += 1 }
        if selectedDateRange != .all { count += 1 }
        if selectedEventTypeId != nil { count += 1 }
        return count
    }
    
    // MARK: Initial Load
    func loadInitialData() async {
        await loadEventTypes()
        await loadEvents()
    }
    
    // MARK: Events Loading
    func loadEvents(
        eventTypeId: Int? = nil,
        searchKeyword: String? = nil,
        onlyAvailable: Bool? = nil,
        location: String? = nil
    ) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            events = try await apiService.getEvents(
                eventTypeId: eventTypeId,
                location: location,
                searchKeyword: searchKeyword,
                onlyAvailable: onlyAvailable
            )
        } catch {
            handleError(error)
        }
    }
    
    func loadEventTypes() async {
        do {
            eventTypes = try await apiService.getEventTypes()
        } catch {
            handleError(error)
        }
    }
    
    func refreshEvents() async {
        await loadEvents()
    }
    
    // MARK: Event Type Selection
    func handleEventTypeSelection(_ typeId: Int?) {
        selectedEventType = typeId
        Task {
            await loadEvents(
                eventTypeId: typeId,
                searchKeyword: searchText.isEmpty ? nil : searchText,
                onlyAvailable: onlyAvailable ? true : nil,
                location: selectedLocation.isEmpty ? nil : selectedLocation  
            )
        }
    }
    
    // MARK: Search Handling
    func handleSearchChange(_ newValue: String) {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            guard !Task.isCancelled else { return }
            await loadEvents(
                eventTypeId: selectedEventType,
                searchKeyword: newValue.isEmpty ? nil : newValue
            )
        }
    }
    
    // MARK: Filter Methods
    func resetFilters() {
        onlyAvailable = false
        selectedLocation = ""
        selectedDateRange = .all
        selectedEventTypeId = nil
    }
    
    func getFilterParameters() -> EventFilterParameters {
        EventFilterParameters(
            onlyAvailable: onlyAvailable ? true : nil,
            location: selectedLocation.isEmpty ? nil : selectedLocation,
            dateRange: selectedDateRange != .all ? selectedDateRange : nil,
            eventTypeId: selectedEventTypeId
        )
    }
    
    func applyFilters(_ parameters: EventFilterParameters) {
        Task {
            await loadEvents(
                eventTypeId: parameters.eventTypeId,
                searchKeyword: searchText.isEmpty ? nil : searchText,
                onlyAvailable: parameters.onlyAvailable,
                location: parameters.location
            )
        }
    }
}
