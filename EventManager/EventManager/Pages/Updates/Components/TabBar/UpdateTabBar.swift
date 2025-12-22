//
//  UpdateTabBar.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//
//
import SwiftUI

struct UpdateTabItem: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
