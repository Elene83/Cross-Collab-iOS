import SwiftUI

struct LocationSection: View {
    @Binding var selectedLocation: String
    
    var body: some View {
        Section("Location") {
            TextField("Enter location", text: $selectedLocation)
        }
        .foregroundStyle(Color.appGray)
    }
}
