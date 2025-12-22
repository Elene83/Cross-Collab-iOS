//
//  EventDetailHeader.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EventDetailHeader: View {
    let event: UpdateEventDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 8) {
                Image(systemName: "location")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

#Preview{
    UpdatesView()
}
