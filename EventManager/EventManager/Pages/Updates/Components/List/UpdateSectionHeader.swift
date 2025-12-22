//
//  UpdateSectionHeader.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct UpdateSectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
    }
}
