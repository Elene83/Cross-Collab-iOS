//
//  StatusBadge.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct StatusBadge: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color)
            .cornerRadius(6)
    }
}
