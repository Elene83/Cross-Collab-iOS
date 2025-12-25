import SwiftUI

struct PasswordSection: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Password")
                    .font(.system(size: 14))
                    .foregroundColor(.appDarkGray)
                Spacer()
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .font(.system(size: 14))
                        .foregroundColor(.appViolet)
                }
            }
            
            if showPassword {
                TextField("Create password", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
                
            } else {
                SecureField("Create password", text: $password)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            
            Text("Password must be at least 6 characters with uppercase, lowercase, and number.")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    SignInView()
}
