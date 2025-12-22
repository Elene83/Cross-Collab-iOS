//
//  SignInView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var showPassword = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SignInHeaderView()
                
                VStack(alignment: .leading, spacing: 24) {
                    SignInEmailField(email: $email)
                    
                    SignInPasswordField(password: $password, showPassword: $showPassword)
                    
                    RememberMeForgotSection(
                        rememberMe: $rememberMe,
                        onForgotPassword: {
                            coordinator.push(.forgotPassword)
                        }
                )
                    Button(action: {
                        appCoordinator.login()
                    }) {
                        Text("Sign In")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                    
                    SignUpPromptView(onSignUp: {
                        coordinator.push(.registration)
                    })
                    .padding(.top, 8)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    SignInView()
}
