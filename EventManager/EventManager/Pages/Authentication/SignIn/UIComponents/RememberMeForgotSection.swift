import SwiftUI

struct RememberMeForgotSection: View {
    @Binding var rememberMe: Bool
    let onForgotPassword: () -> Void
    
    var body: some View {
        HStack {
            Button {
                rememberMe.toggle()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                        .font(.system(size: 18))
                        .foregroundColor(rememberMe ? .appViolet : .gray)
                    Text("Remember me")
                        .font(.system(size: 14))
                        .foregroundColor(.appDarkGray)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button("Forgot password?", action: onForgotPassword)
                .font(.system(size: 14))
                .foregroundColor(.appDarkGray)
        }
    }
}
