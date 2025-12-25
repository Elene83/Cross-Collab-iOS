import SwiftUI
import Combine

struct ProfileView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let profile = viewModel.userProfile {
                    ProfileHeaderView(
                        fullName: profile.fullName,
                        profileImageUrl: nil
                    )
                    
                    AccountInfoSection(
                        email: profile.email,
                        department: profile.role
                    )
                    
                    LogOutButton {
                        viewModel.logout()
                        appCoordinator.logout()
                    }
                    
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

#Preview {
    ProfileView()
}
