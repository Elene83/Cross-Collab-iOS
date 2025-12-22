//
//  EventFiltersView.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventFiltersView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: BrowseEventsViewModel
    let onApply: (EventFilterParameters) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                AvailabilitySection(onlyAvailable: $viewModel.onlyAvailable)
                LocationSection(selectedLocation: $viewModel.selectedLocation)
                DateRangeSection(selectedDateRange: $viewModel.selectedDateRange)
                
                if viewModel.hasActiveFilters {
                    ActiveFiltersSection(activeFiltersCount: viewModel.activeFiltersCount)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ResetButton(
                        hasActiveFilters: viewModel.hasActiveFilters,
                        action: viewModel.resetFilters
                    )
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    ApplyButton(action: {
                        applyFilters()
                    })
                }
            }
        }
    }
    
    private func applyFilters() {
        let parameters = viewModel.getFilterParameters()
        onApply(parameters)
        isPresented = false
    }
}
