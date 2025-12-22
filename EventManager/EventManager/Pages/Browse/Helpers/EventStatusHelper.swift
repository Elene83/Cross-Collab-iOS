//
//  EventStatusHelper.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventStatusHelper {
    static func getStatusBadge(for event: EventListDto) -> (text: String, color: Color) {
        if event.isFull {
            return ("Full", .red)
        } else if Double(event.confirmedCount) / Double(event.capacity) > 0.8 {
            return ("Waitlist", .orange)
        } else {
            return ("Available", .green)
        }
    }
}
