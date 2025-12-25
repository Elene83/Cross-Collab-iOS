import SwiftUI

struct UpdateDetailSheet: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    let event: UpdateEventDetail
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            SheetHandle()
            
            EventDetailHeader(event: event)
            
            EventActionButtons(onFAQTapped: {
                isPresented = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    appCoordinator.selectedTab = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        NotificationCenter.default.post(
                            name: NSNotification.Name("ScrollToFAQ"),
                            object: nil
                        )
                    }
                }
            })
            Spacer()
            Button(action: {
                isPresented = false
            }) {
                Text("Close")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.appDarkGray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
            }
            .padding(.horizontal, 24)
        }
    }
}
