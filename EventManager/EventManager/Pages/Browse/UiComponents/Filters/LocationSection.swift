//
//  LocationSection.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct LocationSection: View {
    @Binding var selectedLocation: String
    
    var body: some View {
        Section("Location") {
            TextField("Enter location", text: $selectedLocation)
        }
    }
}
