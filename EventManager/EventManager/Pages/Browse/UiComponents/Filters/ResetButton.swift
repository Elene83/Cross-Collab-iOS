import SwiftUI

struct ResetButton: View {
    let hasActiveFilters: Bool
    let action: () -> Void
    
    var body: some View {
        Button("Reset", action: action)
            .disabled(!hasActiveFilters)
            .foregroundStyle(Color.appRed)
            .fontWeight(.semibold)
    }
}
