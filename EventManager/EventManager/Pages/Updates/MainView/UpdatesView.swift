import SwiftUI

struct UpdatesView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var viewModel = UpdatesViewModel()
    @State private var selectedEvent: UpdateEventDetail?
    @State private var selectedNotificationId: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 32) {
                        ForEach(UpdatesViewModel.FilterType.allCases, id: \.self) { filter in
                            UpdateTabItem(
                                title: filter.rawValue,
                                isSelected: viewModel.selectedFilter == filter,
                                action: {
                                    viewModel.selectedFilter = filter
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .background(Color(.systemBackground))
                
                ScrollView {
                    LazyVStack(spacing: 16, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.groupedNotifications) { group in
                            Section(header: UpdateSectionHeader(title: group.title)) {
                                ForEach(group.notifications) { notification in
                                    UpdateCard(
                                        icon: viewModel.getIconName(for: notification.type),
                                        title: notification.message,
                                        time: viewModel.formatTime(notification.timestamp),
                                        isUnread: !viewModel.readNotificationIds.contains(notification.id),
                                        onTap: {
                                            if let event = notification.eventDetail {
                                                selectedEvent = event
                                                selectedNotificationId = notification.id
                                            }
                                        }
                                    )
                                    .id("\(notification.id)-\(viewModel.readNotificationIds.count)")
                                    
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.hasUnreadInCurrentFilter {
                        Button("Mark All Read") {
                            viewModel.markAllAsRead()
                        }
                        .font(.subheadline)
                    }
                }
            }
        }
        .sheet(item: $selectedEvent) { event in
            UpdateDetailSheet(event: event, isPresented: Binding(
                get: { selectedEvent != nil },
                set: { if !$0 { selectedEvent = nil } }
            ))
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            .onDisappear {
                if let notificationId = selectedNotificationId {
                    viewModel.markAsReadById(notificationId)
                    selectedNotificationId = nil
                }
            }
        }
    }
}

#Preview {
    UpdatesView()
}
