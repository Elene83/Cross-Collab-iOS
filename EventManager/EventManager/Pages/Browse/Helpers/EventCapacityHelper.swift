//
//  EventCapacityHelper.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import Foundation

struct EventCapacityHelper {
    static func calculateSpotsLeft(for event: EventListDto) -> Int {
        return event.capacity - event.confirmedCount
    }
}
