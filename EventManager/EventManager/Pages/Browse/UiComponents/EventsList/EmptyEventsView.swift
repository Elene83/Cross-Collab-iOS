//
//  EmptyEventsView.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct EmptyEventsView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 12) {
                Image(systemName: "calendar.badge.exclamationmark")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                
                Text("No events found")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}
