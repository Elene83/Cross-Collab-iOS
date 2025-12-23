//
//  UpdateCard.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct UpdateCard: View {
    let icon: String
    let title: String
    let time: String
    let isUnread: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 16) {
                UpdateIcon(systemName: icon)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.appDarkGray)
                        .multilineTextAlignment(.leading)
                    
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.appDarkGray)
                }
                
                Spacer()
                
                if isUnread {
                    UnreadIndicator()
                }
            }
            .padding(16)
            .background(isUnread ? Color(.appBlue).opacity(0.10) : Color(.systemBackground))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
    }
}

#Preview {
    UpdatesView()
}
