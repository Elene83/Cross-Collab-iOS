//
//  RegisterForEventRequest.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import Foundation

struct RegisterForEventRequest: Codable {
    let eventId: Int
    let userId: Int
}

struct RegistrationDto: Codable, Identifiable {
    let id: Int
    let eventId: Int
    let userId: Int
    let status: String
    let registeredAt: String
    let position: Int?
}

struct UserRegistrationDto: Codable, Identifiable {
    let registrationId: Int
    let eventId: Int
    let eventTitle: String
    let eventType: String
    let startDateTime: String
    let location: String
    let status: String
    let registeredAt: String
    
    var id: Int { registrationId }
}

struct EventRegistrationDto: Codable, Identifiable {
    let registrationId: Int
    let userId: Int
    let userName: String
    let userEmail: String
    let status: String
    let registeredAt: String
    
    var id: Int { registrationId }
}

struct UpdateEventDetail: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let location: String
}
