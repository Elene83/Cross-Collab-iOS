//
//  EventHeaderRow.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventHeaderRow: View {
    let eventTypeName: String
    let statusBadge: (text: String, color: Color)
    
    var body: some View {
        HStack {
            Text(eventTypeName)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            StatusBadge(text: statusBadge.text, color: statusBadge.color)
        }
    }
}
