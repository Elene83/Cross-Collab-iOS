import SwiftUI

struct SignUpPromptView: View {
    let onSignUp: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .font(.system(size: 14))
                .foregroundColor(.appDarkGray)
            Button("Sign up", action: onSignUp)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.appViolet)
        }
        .frame(maxWidth: .infinity)
    }
}
