import SwiftUI

struct AccountInfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.appViolet)
                .frame(width: 24)
            
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.appDarkGray)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.appDarkGray)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(16)
    }
}
#Preview {
    ProfileView()
}
