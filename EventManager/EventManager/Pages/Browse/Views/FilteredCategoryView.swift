import SwiftUI

struct FilteredCategoryView: View {
    let eventType: EventTypeDto
    @State private var viewModel = FilteredCategoryViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryHeader(eventType: eventType)
                
                EventsListContent(
                    isLoading: viewModel.isLoading,
                    events: viewModel.events,
                    errorMessage: viewModel.errorMessage,
                    retryAction: {
                        Task {
                            await viewModel.loadEvents(eventTypeId: eventType.id)
                        }
                    }
                )
            }
            .navigationTitle(eventType.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .task {
            await viewModel.loadEvents(eventTypeId: eventType.id)
        }
    }
}
