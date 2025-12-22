//
//  EventLocationRow.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventLocationRow: View {
    let location: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "location")
                .font(.caption)
            Text(location)
                .font(.caption)
                .lineLimit(1)
        }
        .foregroundColor(.secondary)
    }
}
