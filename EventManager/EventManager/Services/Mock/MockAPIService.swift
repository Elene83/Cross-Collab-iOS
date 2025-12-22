//
//  MockAPIService.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import Foundation
import SwiftUI

class MockAPIService: APIServiceProtocol {
    static let shared = MockAPIService()
    private let mockData = MockDataManager.shared
    
    private init() {}
    
    private func simulateNetworkDelay() async throws {
        try await Task.sleep(nanoseconds: UInt64.random(in: 500_000_000...1_500_000_000))
    }
    
    // MARK: User
    func getCurrentUser() async throws -> UserProfileDto {
        try await simulateNetworkDelay()
        return mockData.mockUsers[0]
    }
    
    // MARK: Events
    func getEvents(
        eventTypeId: Int? = nil,
        location: String? = nil,
        searchKeyword: String? = nil,
        onlyAvailable: Bool? = nil
    ) async throws -> [EventListDto] {
        try await simulateNetworkDelay()
        
        var events = mockData.mockEvents
        
        if let eventTypeId = eventTypeId {
            let eventTypeName = mockData.mockEventTypes.first(where: { $0.id == eventTypeId })?.name
            events = events.filter { $0.eventTypeName == eventTypeName }
        }
        
        if let location = location, !location.isEmpty {
            events = events.filter { $0.location.localizedCaseInsensitiveContains(location) }
        }
        
        if let keyword = searchKeyword, !keyword.isEmpty {
            events = events.filter {
                $0.title.localizedCaseInsensitiveContains(keyword) ||
                $0.eventTypeName.localizedCaseInsensitiveContains(keyword) ||
                $0.location.localizedCaseInsensitiveContains(keyword)
            }
        }
        
        if let onlyAvailable = onlyAvailable, onlyAvailable {
            events = events.filter { !$0.isFull }
        }
        
        return events
    }
    
    func getEventDetails(id: Int) async throws -> EventDetailsDto {
        try await simulateNetworkDelay()
        
        guard let event = mockData.getEventDetails(id: id) else {
            throw APIError.notFound("Event not found")
        }
        
        return event
    }
    
    func getUpcomingEvents() async throws -> [EventListDto] {
        try await simulateNetworkDelay()
        
        let now = Date()
        let formatter = ISO8601DateFormatter()
        
        return mockData.mockEvents.filter { event in
            if let eventDate = formatter.date(from: event.startDateTime) {
                return eventDate > now
            }
            return false
        }.sorted { event1, event2 in
            let date1 = formatter.date(from: event1.startDateTime) ?? Date()
            let date2 = formatter.date(from: event2.startDateTime) ?? Date()
            return date1 < date2
        }
    }
    
    func getEventTypes() async throws -> [EventTypeDto] {
        try await simulateNetworkDelay()
        return mockData.mockEventTypes
    }
    
    // MARK:  Event Creation
    func createEvent(request: CreateEventRequest) async throws -> EventDetailsDto {
        try await simulateNetworkDelay()
        
        if request.title.isEmpty {
            throw APIError.badRequest(APIErrorResponse(
                message: "Validation failed",
                errorCode: "VALIDATION_ERROR",
                statusCode: 400,
                timestamp: ISO8601DateFormatter().string(from: Date()),
                details: ["Title": ["Title is required"]]
            ))
        }
        
        if request.capacity < 1 {
            throw APIError.badRequest(APIErrorResponse(
                message: "Validation failed",
                errorCode: "VALIDATION_ERROR",
                statusCode: 400,
                timestamp: ISO8601DateFormatter().string(from: Date()),
                details: ["Capacity": ["Capacity must be at least 1"]]
            ))
        }
        
        let newId = (mockData.mockEvents.map { $0.id }.max() ?? 0) + 1
        
        return EventDetailsDto(
            id: newId,
            title: request.title,
            description: request.description,
            eventTypeName: mockData.mockEventTypes.first(where: { $0.id == request.eventTypeId })?.name ?? "Unknown",
            startDateTime: request.startDateTime,
            endDateTime: request.endDateTime,
            location: request.location,
            capacity: request.capacity,
            imageUrl: request.imageUrl,
            confirmedCount: 0,
            waitlistedCount: 0,
            isFull: false,
            tags: [],
            createdBy: "Current User"
        )
    }
    
    // MARK: Registrations
    func registerForEvent(eventId: Int, userId: Int) async throws -> RegistrationDto {
        try await simulateNetworkDelay()
        
        guard let event = mockData.mockEvents.first(where: { $0.id == eventId }) else {
            throw APIError.notFound("Event not found")
        }
        
        if mockData.mockUserRegistrations.contains(where: { $0.eventId == eventId }) {
            throw APIError.conflict("Already registered for this event")
        }
        
        let status: String
        let position: Int?
        
        if event.confirmedCount < event.capacity {
            status = "Confirmed"
            position = nil
        } else {
            status = "Waitlisted"
            position = event.confirmedCount - event.capacity + 1
        }
        
        return RegistrationDto(
            id: Int.random(in: 100...999),
            eventId: eventId,
            userId: userId,
            status: status,
            registeredAt: ISO8601DateFormatter().string(from: Date()),
            position: position
        )
    }
    
    func cancelRegistration(id: Int) async throws {
        try await simulateNetworkDelay()
        
        guard mockData.mockUserRegistrations.contains(where: { $0.registrationId == id }) else {
            throw APIError.notFound("Registration not found")
        }
    }
    
    func getUserRegistrations(userId: Int) async throws -> [UserRegistrationDto] {
        try await simulateNetworkDelay()
        return mockData.mockUserRegistrations
    }
    
    func getEventRegistrations(eventId: Int) async throws -> [EventRegistrationDto] {
        try await simulateNetworkDelay()
        
        return [
            EventRegistrationDto(
                registrationId: 1,
                userId: 1,
                userName: "John Doe",
                userEmail: "john.doe@company.com",
                status: "Confirmed",
                registeredAt: "2024-12-15T10:00:00Z"
            ),
            EventRegistrationDto(
                registrationId: 2,
                userId: 4,
                userName: "Bob Wilson",
                userEmail: "bob.wilson@company.com",
                status: "Confirmed",
                registeredAt: "2024-12-16T14:30:00Z"
            )
        ]
    }
    
    // MARK: Password Reset
    func sendPasswordResetLink(email: String) async throws {
        try await simulateNetworkDelay()
        
        guard mockData.mockUsers.contains(where: { $0.email == email }) else {
            throw APIError.notFound("User with this email not found")
        }
    }
    
    // MARK: Notifications
    func getNotifications(userId: Int) async throws -> [NotificationDto] {
        try await simulateNetworkDelay()
        
        let calendar = Calendar.current
        let now = Date()
        let formatter = ISO8601DateFormatter()
        
        let mockNotifications: [NotificationDto] = [
            NotificationDto(
                id: 1,
                userId: userId,
                type: .eventReminder,
                title: "Event Starting Soon",
                message: "Reminder: \"Tech Talk: AI in Business\" starts in 1 hour.",
                eventId: 2,
                isRead: false,
                createdAt: formatter.string(from: calendar.date(byAdding: .hour, value: -1, to: now)!)
            ),
            NotificationDto(
                id: 2,
                userId: userId,
                type: .waitlistPromotion,
                title: "You're In!",
                message: "You have been moved from the waitlist and are now registered for \"Friday Pizza & Games Night\".",
                eventId: 3,
                isRead: false,
                createdAt: formatter.string(from: calendar.date(byAdding: .hour, value: -2, to: now)!)
            ),
            NotificationDto(
                id: 3,
                userId: userId,
                type: .registrationConfirmed,
                title: "Registration Confirmed",
                message: "You are now registered for \"Company Soccer Tournament\".",
                eventId: 4,
                isRead: true,
                createdAt: formatter.string(from: calendar.date(byAdding: .hour, value: -3, to: now)!)
            ),
            NotificationDto(
                id: 4,
                userId: userId,
                type: .organizerUpdate,
                title: "Event Update",
                message: "The location for \"Annual Team Building Retreat\" has been updated.",
                eventId: 1,
                isRead: true,
                createdAt: formatter.string(from: calendar.date(byAdding: .day, value: -1, to: now)!)
            ),
            NotificationDto(
                id: 5,
                userId: userId,
                type: .ratingRequest,
                title: "Rate Your Experience",
                message: "Please rate your experience at \"Leadership Workshop: Effective Communication\".",
                eventId: 5,
                isRead: false,
                createdAt: formatter.string(from: calendar.date(byAdding: .day, value: -5, to: now)!)
            ),
            NotificationDto(
                id: 6,
                userId: userId,
                type: .newEvent,
                title: "New Event Posted",
                message: "New Event: A \"Cultural Day Celebration\" event has been posted. Check it out!",
                eventId: 6,
                isRead: false,
                createdAt: formatter.string(from: calendar.date(byAdding: .day, value: -5, to: now)!)
            ),
            NotificationDto(
                id: 7,
                userId: userId,
                type: .eventReminder,
                title: "Event Tomorrow",
                message: "Reminder: \"Yoga & Meditation Session\" is happening tomorrow at 7:00 AM.",
                eventId: 7,
                isRead: true,
                createdAt: formatter.string(from: calendar.date(byAdding: .day, value: -7, to: now)!)
            ),
            NotificationDto(
                id: 8,
                userId: userId,
                type: .eventCancellation,
                title: "Event Cancelled",
                message: "Unfortunately, \"Team Lunch: Japanese Cuisine\" has been cancelled due to unforeseen circumstances.",
                eventId: nil,
                isRead: true,
                createdAt: formatter.string(from: calendar.date(byAdding: .day, value: -10, to: now)!)
            )
        ]
        
        return mockNotifications
    }
    
    func markNotificationAsRead(id: Int) async throws {
        try await simulateNetworkDelay()
    }
    
    func markAllNotificationsAsRead(userId: Int) async throws {
        try await simulateNetworkDelay()
    }
}
