//
//  ForgotPasswordView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 24) {
                ForgotPasswordHeaderView()
                
                ForgotPasswordEmailField(email: $email)
                    .padding(.top, 24)
                
                Button(action: {}) {
                    Text("Send Reset Link")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.appViolet)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)
                
                BackToSignInButton(onBack: {
                    coordinator.pop()  
                })
                .padding(.top, 16)
            }
            .padding(.vertical, 48)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: 4)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    ForgotPasswordView()
}
