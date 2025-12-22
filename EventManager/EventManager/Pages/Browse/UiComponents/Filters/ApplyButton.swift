//
//  ApplyButton.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct ApplyButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Apply", action: action)
            .fontWeight(.semibold)
    }
}
