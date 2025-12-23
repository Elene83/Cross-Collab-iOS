//
//  SignInPasswordField.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct SignInPasswordField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            
            HStack {
                if showPassword {
                    TextField("Enter your password", text: $password)
                } else {
                    SecureField("Enter your password", text: $password)
                }
                
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .font(.system(size: 14))
                        .foregroundColor(.appViolet)
                }
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
