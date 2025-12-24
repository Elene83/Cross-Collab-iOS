import SwiftUI
import Combine

struct ProfileView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let profile = viewModel.userProfile {
                    VStack(spacing: 16) {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text(profile.fullName.prefix(1).uppercased())
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.blue)
                            )
                        
                        Text(profile.fullName)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .background(Color.white)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Email")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(profile.email)
                                .fontWeight(.medium)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("Role")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(profile.role)
                                .fontWeight(.medium)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                    
                    Button {
                        viewModel.logout()
                        appCoordinator.logout()
                    } label: {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding()
                    
                } else if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 100)
                }
            }
        }
        .background(Color(.systemGray6))
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}
