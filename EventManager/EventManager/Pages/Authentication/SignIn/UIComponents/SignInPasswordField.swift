import SwiftUI

struct SignInPasswordField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    var showHint: Bool = false
    var onUseSavedPassword: (() -> Void)?
        
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            
            HStack {
                if showPassword {
                    TextField("Enter your password", text: $password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } else {
                    SecureField("Enter your password", text: $password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                if showHint {
                    Button(action: {
                        onUseSavedPassword?()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "key.fill")
                                .font(.system(size: 12))
                            Text("Use saved")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(.appViolet)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.appViolet.opacity(0.1))
                        .cornerRadius(6)
                    }
                    .buttonStyle(PlainButtonStyle()) 
                }
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .font(.system(size: 14))
                        .foregroundColor(.appViolet)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            .frame(height: 48)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
    }
}

#Preview {
    SignInView()
}
