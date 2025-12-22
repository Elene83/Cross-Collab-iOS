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
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .frame(height: 48)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}
