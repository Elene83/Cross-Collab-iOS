//
//  DateBadgeView.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct DateBadgeView: View {
    let dateString: String
    
    private var dateComponents: (month: String, day: String) {
        DateFormatter.parseDateComponents(from: dateString)
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text(dateComponents.month)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Text(dateComponents.day)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .frame(width: 60)
    }
}


