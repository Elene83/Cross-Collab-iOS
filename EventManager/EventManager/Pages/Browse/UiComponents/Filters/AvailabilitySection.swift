//
//  AvailabilitySection.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct AvailabilitySection: View {
    @Binding var onlyAvailable: Bool
    
    var body: some View {
        Section {
            Toggle("Only show available events", isOn: $onlyAvailable)
        }
    }
}
