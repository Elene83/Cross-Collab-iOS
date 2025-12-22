//
//  EventRegistrationRow.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct EventRegistrationRow: View {
    let event: EventListDto
    
    private var spotsLeft: Int {
        EventCapacityHelper.calculateSpotsLeft(for: event)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 4) {
                Image(systemName: "person.2")
                    .font(.caption)
                Text("\(event.confirmedCount) registered")
                    .font(.caption)
            }
            
            HStack(spacing: 4) {
                Image(systemName: event.isFull ? "person.fill.xmark" : "person.fill.checkmark")
                    .font(.caption)
                Text(event.isFull ? "0 spots left" : "\(spotsLeft) spots left")
                    .font(.caption)
            }
        }
        .foregroundColor(.secondary)
    }
}
