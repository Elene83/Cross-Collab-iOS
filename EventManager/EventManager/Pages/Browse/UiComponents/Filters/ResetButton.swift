//
//  ResetButton.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct ResetButton: View {
    let hasActiveFilters: Bool
    let action: () -> Void
    
    var body: some View {
        Button("Reset", action: action)
            .disabled(!hasActiveFilters)
    }
}
