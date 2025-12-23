//
//  ActionButton.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct ActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.appViolet)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.appDarkGray)
                
                Spacer()
            }
            .padding(16)
            .background(Color(.appBlue).opacity(0.10))
            .cornerRadius(12)
        }
    }
}

#Preview {
    UpdatesView()
}
