//
//  SearchField.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appViolet)
            
            TextField("Search events...", text: $searchText)
                .textFieldStyle(.plain)
        }
        .padding(12)
        .background(Color(.appBlue).opacity(0.10))
        .cornerRadius(12)
    }
}

