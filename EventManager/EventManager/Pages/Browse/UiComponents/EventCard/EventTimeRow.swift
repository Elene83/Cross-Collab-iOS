//
//  EventTimeRow.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventTimeRow: View {
    let dateString: String
    
    private var timeString: String {
        DateFormatter.parseTimeString(from: dateString)
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock")
                .font(.caption)
            Text(timeString)
                .font(.caption)
        }
        .foregroundColor(.secondary)
    }
}
