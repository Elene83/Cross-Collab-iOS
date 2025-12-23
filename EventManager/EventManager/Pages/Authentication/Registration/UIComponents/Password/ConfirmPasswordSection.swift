import SwiftUI

struct ConfirmPasswordSection: View {
    @Binding var confirmPassword: String
    @Binding var showConfirmPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Confirm Password")
                    .font(.system(size: 14))
                    .foregroundColor(.appDarkGray)
                Spacer()
                Button(action: { showConfirmPassword.toggle() }) {
                    Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                        .font(.system(size: 14))
                        .foregroundColor(.appViolet)
                }
            }
            
            if showConfirmPassword {
                TextField("Confirm password", text: $confirmPassword)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                SecureField("Confirm password", text: $confirmPassword)
                    .textFieldStyle(CustomTextFieldStyle())
            }
        }
    }
}
