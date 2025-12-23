//
//  UpdatesViewModel.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import Foundation
import SwiftUI

@Observable
class UpdatesViewModel {
    var notifications: [UpdateNotification] = []
    var selectedFilter: FilterType = .all
    var isLoading = false
    var readNotificationIds: Set<Int> = []
    
    var unreadCount: Int {
        notifications.filter { !readNotificationIds.contains($0.id) }.count
    }
    
    var hasUnreadInCurrentFilter: Bool {
        let currentNotifications = getFilteredNotifications()
        return currentNotifications.contains { !readNotificationIds.contains($0.id) }
    }
    
    var groupedNotifications: [NotificationGroup] {
        let filtered = getFilteredNotifications()
        return groupByDate(filtered)
    }
    
    enum FilterType: String, CaseIterable {
        case all = "All"
        case registrations = "Registrations"
        case reminders = "Reminders"
        case updates = "Updates"
    }
    
    init() {
        loadNotifications()
    }
    
    func loadNotifications() {
        notifications = [
            UpdateNotification(
                id: 1,
                type: .reminder,
                title: "Event Starting Soon",
                message: "Reminder: \"Tech Talk: AI in Business\" starts in 1 hour.",
                timestamp: Date().addingTimeInterval(-3600),
                eventId: 2,
                eventTitle: "Tech Talk: AI in Business",
                eventDate: "Jan 26, 2025, 11:00 AM - 12:30 PM",
                eventLocation: "Virtual Meeting"
            ),
            UpdateNotification(
                id: 2,
                type: .waitlistPromotion,
                title: "You're In!",
                message: "You have been moved from the waitlist and are now registered for \"Happy Friday: Game Night\".",
                timestamp: Date().addingTimeInterval(-7200),
                eventId: 3,
                eventTitle: "Happy Friday: Game Night",
                eventDate: "Dec 27, 2024, 6:00 PM - 10:00 PM",
                eventLocation: "Main Office Lounge"
            ),
            UpdateNotification(
                id: 3,
                type: .registrationConfirmed,
                title: "Registration Confirmed",
                message: "You are now registered for \"Company Soccer Tournament\".",
                timestamp: Date().addingTimeInterval(-10800),
                eventId: 4,
                eventTitle: "Company Soccer Tournament",
                eventDate: "Jan 5, 2025, 10:00 AM - 2:00 PM",
                eventLocation: "City Sports Complex"
            ),
            UpdateNotification(
                id: 4,
                type: .organizerUpdate,
                title: "Event Update",
                message: "The location for \"Annual Team Building Retreat\" has been updated.",
                timestamp: Date().addingTimeInterval(-86400),
                eventId: 1,
                eventTitle: "Annual Team Building Retreat",
                eventDate: "Dec 28, 2024, 9:00 AM - 5:00 PM",
                eventLocation: "Mountain Resort, Gudauri"
            ),
            UpdateNotification(
                id: 5,
                type: .ratingRequest,
                title: "Rate Your Experience",
                message: "Please rate your experience at \"Leadership Workshop: Effective Communication\".",
                timestamp: Date().addingTimeInterval(-432000),
                eventId: 5,
                eventTitle: "Leadership Workshop: Effective Communication",
                eventDate: "Dec 16, 2024, 9:00 AM - 5:00 PM",
                eventLocation: "Conference Center"
            ),
            UpdateNotification(
                id: 6,
                type: .newEvent,
                title: "New Event Posted",
                message: "New Event: A \"Cultural Day Celebration\" event has been posted. Check it out!",
                timestamp: Date().addingTimeInterval(-432000),
                eventId: 6,
                eventTitle: "Cultural Day Celebration",
                eventDate: "Jan 10, 2025, 2:00 PM - 6:00 PM",
                eventLocation: "Grand Hall"
            ),
            UpdateNotification(
                id: 7,
                type: .reminder,
                title: "Event Tomorrow",
                message: "Reminder: \"Yoga & Meditation Session\" is happening tomorrow at 7:00 AM.",
                timestamp: Date().addingTimeInterval(-604800),
                eventId: 7,
                eventTitle: "Yoga & Meditation Session",
                eventDate: "Jan 8, 2025, 7:00 AM - 8:00 AM",
                eventLocation: "Rooftop Garden"
            ),
            UpdateNotification(
                id: 8,
                type: .cancellation,
                title: "Event Cancelled",
                message: "Unfortunately, \"Team Lunch: Japanese Cuisine\" has been cancelled due to unforeseen circumstances.",
                timestamp: Date().addingTimeInterval(-864000),
                eventId: nil,
                eventTitle: nil,
                eventDate: nil,
                eventLocation: nil
            )
        ]
        
        readNotificationIds = [3, 4, 7, 8]
    }
    
    private func getFilteredNotifications() -> [UpdateNotification] {
        switch selectedFilter {
        case .all:
            return notifications
        case .registrations:
            return notifications.filter {
                $0.type == .registrationConfirmed || $0.type == .waitlistPromotion
            }
        case .reminders:
            return notifications.filter {
                $0.type == .reminder
            }
        case .updates:
            return notifications.filter {
                $0.type == .organizerUpdate || $0.type == .cancellation ||
                $0.type == .newEvent || $0.type == .ratingRequest
            }
        }
    }
    
    func isRead(_ notificationId: Int) -> Bool {
        readNotificationIds.contains(notificationId)
    }
    
    func markAsReadById(_ id: Int) {
        markAsRead(ids: [id])
    }
    
    func markAllAsRead() {
        let currentFilterNotifications = getFilteredNotifications()
        let idsToMarkRead = currentFilterNotifications.map { $0.id }
        markAsRead(ids: idsToMarkRead)
    }
    
    private func markAsRead(ids: [Int]) {
        readNotificationIds.formUnion(ids)
    }
    
    private func groupByDate(_ notifications: [UpdateNotification]) -> [NotificationGroup] {
        let unreadNotifs = notifications.filter { !readNotificationIds.contains($0.id) }
        let readNotifs = notifications.filter { readNotificationIds.contains($0.id) }
        
        var groups: [NotificationGroup] = []
        
        if !unreadNotifs.isEmpty {
            groups.append(NotificationGroup(
                title: "New",
                notifications: unreadNotifs.sorted { $0.timestamp > $1.timestamp }
            ))
        }
        
        if !readNotifs.isEmpty {
            groups.append(NotificationGroup(
                title: "Earlier",
                notifications: readNotifs.sorted { $0.timestamp > $1.timestamp }
            ))
        }
        
        return groups
    }
    
    func getIconName(for type: UpdateNotification.NotificationType) -> String {
        switch type {
        case .registrationConfirmed:
            return "checkmark.circle"
        case .reminder:
            return "calendar"
        case .organizerUpdate:
            return "megaphone"
        case .waitlistPromotion:
            return "list.bullet"
        case .cancellation:
            return "xmark.circle"
        case .ratingRequest:
            return "star"
        case .newEvent:
            return "sparkles"
        }
    }
    
    func formatTime(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy, h:mm a"
            return formatter.string(from: date)
        }
    }
}
