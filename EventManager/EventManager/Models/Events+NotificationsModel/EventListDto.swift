//
//  EventListDto.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import Foundation

struct EventListDto: Codable, Identifiable {
    let id: Int
    let title: String
    let eventTypeName: String
    let startDateTime: String
    let location: String
    let capacity: Int
    let confirmedCount: Int
    let isFull: Bool
    let imageUrl: String?
    let tags: [String]
}

struct EventDetailsDto: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeName: String
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let confirmedCount: Int
    let waitlistedCount: Int
    let isFull: Bool
    let tags: [String]
    let createdBy: String
}

struct CreateEventRequest: Codable {
    let title: String
    let description: String?
    let eventTypeId: Int
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let tagIds: [Int]
}

struct UpdateEventRequest: Codable {
    let title: String
    let description: String?
    let eventTypeId: Int
    let startDateTime: String
    let endDateTime: String
    let location: String
    let capacity: Int
    let imageUrl: String?
    let tagIds: [Int]
}

struct EventTypeDto: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}

struct EventFilterParameters {
    let onlyAvailable: Bool?
    let location: String?
    let dateRange: DateRange?
    let eventTypeId: Int?
}
