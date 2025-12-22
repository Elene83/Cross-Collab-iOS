//
//  BrowseEventsView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct BrowseView: View {
    @StateObject private var viewModel = BrowseEventsViewModel()
    @State private var selectedEventTypeForDetail: EventTypeDto?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar()
                
                SearchAndFilterBar(
                    searchText: $viewModel.searchText,
                    showFilters: $viewModel.showFilters
                )
                
                EventTypeFilterScroll(
                    eventTypes: viewModel.eventTypes,
                    selectedEventType: $viewModel.selectedEventType,
                    onSelection: viewModel.handleEventTypeSelection,
                    onLongPress: { eventType in
                        selectedEventTypeForDetail = eventType
                    }
                )
                
                EventsListContent(
                    isLoading: viewModel.isLoading,
                    events: viewModel.events,
                    errorMessage: viewModel.errorMessage,
                    retryAction: {
                        Task {
                            await viewModel.refreshEvents()
                        }
                    }
                )
            }
            .navigationBarHidden(true)
        }
        .task {
            await viewModel.loadInitialData()
        }
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            viewModel.handleSearchChange(newValue)
        }
        .sheet(isPresented: $viewModel.showFilters) {
            EventFiltersView(
                isPresented: $viewModel.showFilters,
                viewModel: viewModel,
                onApply: viewModel.applyFilters
            )
        }
        .sheet(item: $selectedEventTypeForDetail) { eventType in
            FilteredCategoryView(eventType: eventType)
        }
    }
}

#Preview {
    BrowseView()
}
