//
//  RegistrationView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var otpCode = ["", "", "", "", "", ""]
    @State private var selectedDepartment = "Select Department"
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreedToTerms = false
    @State private var timeRemaining = 50
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var otpSent = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.system(size: 24))
                    Text("Enter your details to get started.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                .padding(.bottom, 32)
                
                VStack(alignment: .leading, spacing: 24) {
                    NameFieldsSection(firstName: $firstName, lastName: $lastName)
                    
                    EmailSection(email: $email)
                    
                    PhoneNumberSection(phoneNumber: $phoneNumber, onSendOTP: {
                        otpSent = true
                        timeRemaining = 50
                    })
                    
                    OTPSection(otpCode: $otpCode, timeRemaining: $timeRemaining)
                    
                    DepartmentSection(selectedDepartment: $selectedDepartment)
                    
                    PasswordSection(password: $password, showPassword: $showPassword)
                    
                    ConfirmPasswordSection(confirmPassword: $confirmPassword, showConfirmPassword: $showConfirmPassword)
                    
                    HStack(alignment: .top, spacing: 12) {
                        Button(action: { agreedToTerms.toggle() }) {
                            Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(agreedToTerms ? .blue : .gray)
                        }
                        
                        Text("I agree to the Terms of Service and Privacy Policy")
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 8)
                    
                    Button(action: {
                        appCoordinator.login()
                    }) {
                        Text("Create Account")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Button("Sign In") {coordinator.pop()
                        }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 && otpSent {
                timeRemaining -= 1
            }
        }
    }
}

#Preview {
    RegistrationView()
}
