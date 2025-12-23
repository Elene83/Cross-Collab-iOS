import SwiftUI

struct AvailabilitySection: View {
    @Binding var onlyAvailable: Bool
    
    var body: some View {
        Section {
            Toggle("Only show available events", isOn: $onlyAvailable)
        }
    }
}
