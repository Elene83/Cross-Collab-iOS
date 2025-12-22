//
//  EventTypeFilterScroll.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventTypeFilterScroll: View {
    let eventTypes: [EventTypeDto]
    @Binding var selectedEventType: Int?
    let onSelection: (Int?) -> Void
    let onLongPress: ((EventTypeDto) -> Void)?
    
    init(
        eventTypes: [EventTypeDto],
        selectedEventType: Binding<Int?>,
        onSelection: @escaping (Int?) -> Void,
        onLongPress: ((EventTypeDto) -> Void)? = nil
    ) {
        self.eventTypes = eventTypes
        self._selectedEventType = selectedEventType
        self.onSelection = onSelection
        self.onLongPress = onLongPress
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                EventTypeFilterChip(
                    title: "All",
                    isSelected: selectedEventType == nil,
                    action: { onSelection(nil) }
                )
                
                ForEach(eventTypes) { type in
                    EventTypeFilterChip(
                        title: type.name,
                        isSelected: selectedEventType == type.id,
                        action: { onSelection(type.id) },
                        onLongPress: onLongPress != nil ? { onLongPress?(type) } : nil
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 16)
    }
}
