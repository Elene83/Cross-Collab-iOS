//
//  NotificationDto.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//


import Foundation

// MARK: - Notification DTOs
struct NotificationDto: Codable, Identifiable {
    let id: Int
    let userId: Int
    let type: NotificationType
    let title: String
    let message: String
    let eventId: Int?
    let isRead: Bool
    let createdAt: String
    
    enum NotificationType: String, Codable {
        case registrationConfirmed = "REGISTRATION_CONFIRMED"
        case eventReminder = "EVENT_REMINDER"
        case organizerUpdate = "ORGANIZER_UPDATE"
        case waitlistPromotion = "WAITLIST_PROMOTION"
        case eventCancellation = "EVENT_CANCELLATION"
        case ratingRequest = "RATING_REQUEST"
        case newEvent = "NEW_EVENT"
    }
}

struct NotificationGroupDto {
    let date: String
    let notifications: [NotificationDto]
}

// MARK: - View Models
class NotificationsViewModel: ObservableObject {
    @Published var notifications: [NotificationDto] = []
    @Published var groupedNotifications: [NotificationGroupDto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedFilter: NotificationFilter = .all
    @Published var unreadCount = 0
    
    enum NotificationFilter: String, CaseIterable {
        case all = "All"
        case registrations = "Registrations"
        case reminders = "Reminders"
        case updates = "Updates"
        
        var notificationTypes: [NotificationDto.NotificationType]? {
            switch self {
            case .all:
                return nil
            case .registrations:
                return [.registrationConfirmed, .waitlistPromotion]
            case .reminders:
                return [.eventReminder]
            case .updates:
                return [.organizerUpdate, .eventCancellation, .newEvent, .ratingRequest]
            }
        }
    }
    
    private let apiService = MockAPIService.shared
    
    func loadNotifications(userId: Int) async {
        await MainActor.run { isLoading = true }
        
        do {
            let fetchedNotifications = try await apiService.getNotifications(userId: userId)
            await MainActor.run {
                self.notifications = fetchedNotifications
                self.unreadCount = fetchedNotifications.filter { !$0.isRead }.count
                self.applyFilter()
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func applyFilter() {
        var filtered = notifications
        
        if let types = selectedFilter.notificationTypes {
            filtered = filtered.filter { types.contains($0.type) }
        }
        
        groupedNotifications = groupNotificationsByDate(filtered)
    }
    
    func markAsRead(notificationId: Int) async {
        do {
            try await apiService.markNotificationAsRead(id: notificationId)
            
            await MainActor.run {
                if let index = notifications.firstIndex(where: { $0.id == notificationId }) {
                    let updatedNotification = notifications[index]
                    notifications[index] = NotificationDto(
                        id: updatedNotification.id,
                        userId: updatedNotification.userId,
                        type: updatedNotification.type,
                        title: updatedNotification.title,
                        message: updatedNotification.message,
                        eventId: updatedNotification.eventId,
                        isRead: true,
                        createdAt: updatedNotification.createdAt
                    )
                    unreadCount = notifications.filter { !$0.isRead }.count
                    applyFilter()
                }
            }
        } catch {
            print("Failed to mark notification as read: \(error)")
        }
    }
    
    func markAllAsRead(userId: Int) async {
        do {
            try await apiService.markAllNotificationsAsRead(userId: userId)
            
            await MainActor.run {
                notifications = notifications.map { notification in
                    NotificationDto(
                        id: notification.id,
                        userId: notification.userId,
                        type: notification.type,
                        title: notification.title,
                        message: notification.message,
                        eventId: notification.eventId,
                        isRead: true,
                        createdAt: notification.createdAt
                    )
                }
                unreadCount = 0
                applyFilter()
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    private func groupNotificationsByDate(_ notifications: [NotificationDto]) -> [NotificationGroupDto] {
        let formatter = ISO8601DateFormatter()
        let calendar = Calendar.current
        _ = Date()
        
        let grouped = Dictionary(grouping: notifications) { notification -> String in
            guard let date = formatter.date(from: notification.createdAt) else {
                return "Earlier"
            }
            
            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else {
                return "Earlier"
            }
        }
        
        let order = ["Today", "Yesterday", "Earlier"]
        return order.compactMap { key in
            guard let notifications = grouped[key], !notifications.isEmpty else { return nil }
            return NotificationGroupDto(
                date: key,
                notifications: notifications.sorted { n1, n2 in
                    guard let d1 = formatter.date(from: n1.createdAt),
                          let d2 = formatter.date(from: n2.createdAt) else {
                        return false
                    }
                    return d1 > d2
                }
            )
        }
    }
    
    func getIconName(for type: NotificationDto.NotificationType) -> String {
        switch type {
        case .registrationConfirmed:
            return "checkmark.circle.fill"
        case .eventReminder:
            return "bell.fill"
        case .organizerUpdate:
            return "megaphone.fill"
        case .waitlistPromotion:
            return "arrow.up.circle.fill"
        case .eventCancellation:
            return "xmark.circle.fill"
        case .ratingRequest:
            return "star.fill"
        case .newEvent:
            return "sparkles"
        }
    }
    
    func formatTime(_ isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoString) else {
            return isoString
        }
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            return timeFormatter.string(from: date)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            return dateFormatter.string(from: date)
        }
    }
}
