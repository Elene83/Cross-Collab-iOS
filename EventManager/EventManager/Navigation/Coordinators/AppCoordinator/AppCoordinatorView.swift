import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some View {
        Group {
            if appCoordinator.isAuthenticated {
                MainTabView()
                    .environmentObject(appCoordinator)
            } else {
                AuthCoordinatorView()
                    .environmentObject(appCoordinator)
            }
        }
    }
}
