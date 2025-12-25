import SwiftUI

struct SignInView: View {
    @EnvironmentObject var coordinator: AuthCoordinator
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var viewModel = SignInViewModel()
    @State private var showPassword = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SignInHeaderView()
                
                VStack(alignment: .leading, spacing: 24) {
                    SignInEmailField(email: $viewModel.email)
                    
                    SignInPasswordField(
                        password: $viewModel.password,
                        showPassword: $showPassword
                    )
                    
                    RememberMeForgotSection(
                        rememberMe: .constant(false),
                        onForgotPassword: {
                            coordinator.push(.forgotPassword)
                        }
                    )
                    
                    Button(action: {
                        Task {
                            await viewModel.signIn()
                            let token = TokenManager.shared.getToken()
                            print("DEBUG: Checking token before navigation: \(token ?? "NULL")")
                            
                            if token != nil {
                                print("DEBUG: Token exists, calling appCoordinator.login()")
                                appCoordinator.login() 
                            } else {
                                print("DEBUG: Navigation failed - No token found")
                            }
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                        } else {
                            Text("Sign In")
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
                    
                    SignUpPromptView(onSignUp: {
                        coordinator.push(.registration)
                    })
                    .padding(.top, 8)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
    }
}

#Preview {
    SignInView()
}
