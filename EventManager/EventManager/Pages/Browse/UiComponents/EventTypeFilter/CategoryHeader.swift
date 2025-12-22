//
//  CategoryHeader.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct CategoryHeader: View {
    let eventType: EventTypeDto
    
    var body: some View {
        VStack(spacing: 8) {
            Text(eventType.name)
                .font(.title2)
                .fontWeight(.bold)
            
            if let description = eventType.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
    }
}
