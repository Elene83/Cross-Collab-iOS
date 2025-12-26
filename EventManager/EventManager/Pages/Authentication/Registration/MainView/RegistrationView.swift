import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var viewModel = RegistrationViewModel()
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var timeRemaining = 50
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
                        .foregroundColor(.appGray)
                }
                .padding(.top, 40)
                .padding(.bottom, 32)
                
                VStack(alignment: .leading, spacing: 24) {
                    NameFieldsSection(
                        firstName: $viewModel.firstName,
                        lastName: $viewModel.lastName
                    )
                    
                    EmailSection(email: $viewModel.email)
                    
                    PhoneNumberSection(
                        phoneNumber: $viewModel.phoneNumber,
                        onSendOTP: {
                            otpSent = true
                            timeRemaining = 50
                        }
                    )
                    DepartmentSection(
                        selectedDepartmentId: $viewModel.selectedDepartmentId,
                        departments: viewModel.departments
                    )
                    
                    OTPSection(
                        otpCode: $viewModel.otpCode,
                        timeRemaining: $timeRemaining
                    )
                                        
                    PasswordSection(
                        password: $viewModel.password,
                        showPassword: $showPassword
                    )
                    
                    ConfirmPasswordSection(
                        confirmPassword: $viewModel.confirmPassword,
                        showConfirmPassword: $showConfirmPassword
                    )
                    
                    HStack(alignment: .top, spacing: 12) {
                        Button(action: { viewModel.agreedToTerms.toggle() }) {
                            Image(systemName: viewModel.agreedToTerms ? "checkmark.square.fill" : "square")
                                .font(.system(size: 20))
                                .foregroundColor(viewModel.agreedToTerms ? .appViolet : .gray)
                        }
                        
                        Text("I agree to the Terms of Service and Privacy Policy")
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 8)
                    
                    Button(action: {
                        Task {
                            let success = await viewModel.register()
                                    if success {
                                        coordinator.pop()
                            }
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                        } else {
                            Text("Create Account")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                        }
                    }
                    .background(Color.appViolet)
                    .cornerRadius(8)
                    .disabled(viewModel.isLoading)
                    .padding(.top, 8)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Button("Sign In") {
                            coordinator.pop()
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appViolet)
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
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
        .task {
                    await viewModel.fetchDepartments()
        }
    }
}
