//
//  SearchAndFilterBar.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct SearchAndFilterBar: View {
    @Binding var searchText: String
    @Binding var showFilters: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            SearchField(searchText: $searchText)
            FilterButton(showFilters: $showFilters)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
}
