import SwiftUI

struct LogOutButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 20))
                
                Text("Log Out")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
            }
            .foregroundColor(.appRed)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    ProfileView()
}
