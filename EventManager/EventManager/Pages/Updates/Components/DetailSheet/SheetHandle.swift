import SwiftUI

struct SheetHandle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color(.systemGray4))
            .frame(width: 40, height: 5)
            .padding(.top, 8)
            .padding(.bottom, 16)
    }
}

#Preview {
    UpdatesView()
}
