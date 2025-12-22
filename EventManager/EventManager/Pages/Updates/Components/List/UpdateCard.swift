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
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isUnread {
                    UnreadIndicator()
                }
            }
            .padding(16)
            .background(isUnread ? Color(.systemGray5) : Color(.systemBackground))
        }
    }
}
