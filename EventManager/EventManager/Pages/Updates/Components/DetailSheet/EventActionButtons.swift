import SwiftUI

struct EventActionButtons: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    var onFAQTapped: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            ActionButton(
                icon: "questionmark.circle",
                title: "See frequently asked questions",
                action: {
                    if let onFAQTapped = onFAQTapped {
                        onFAQTapped()
                    } else {
                        appCoordinator.selectedTab = 0
                    }
                }
            )
        }
        .padding(.horizontal, 24)
    }
}
