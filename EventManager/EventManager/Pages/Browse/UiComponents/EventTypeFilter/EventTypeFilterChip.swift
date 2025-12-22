//
//  EventTypeFilterChip.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventTypeFilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    let onLongPress: (() -> Void)?
    
    init(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void,
        onLongPress: (() -> Void)? = nil
    ) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
        self.onLongPress = onLongPress
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.black : Color(.systemGray6))
                .cornerRadius(20)
        }
        .simultaneousGesture(
            onLongPress != nil ? LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    onLongPress?()
                } : nil
        )
    }
}
