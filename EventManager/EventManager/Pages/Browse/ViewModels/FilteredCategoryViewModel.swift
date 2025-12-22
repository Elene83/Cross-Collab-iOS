//
//  FilteredCategoryViewModel.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import Foundation
import SwiftUI

@MainActor
class FilteredCategoryViewModel: ObservableObject, ErrorHandling {
    @Published var events: [EventListDto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = MockAPIService.shared) {
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
                searchKeyword: nil,
                onlyAvailable: nil
            )
        } catch {
            handleError(error)
        }
    }
}
