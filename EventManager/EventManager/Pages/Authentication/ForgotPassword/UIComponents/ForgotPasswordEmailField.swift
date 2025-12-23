//
//  ForgotPasswordEmailField.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct ForgotPasswordEmailField: View {
    @Binding var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Email")
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            HStack(spacing: 12) {
                Image(systemName: "envelope")
                    .font(.system(size: 18))
                    .foregroundColor(.appViolet)
                
                TextField("Enter your email", text: $email)
                    .font(.system(size: 16))
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .padding()
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
        .padding(.horizontal, 32)
    }
}
