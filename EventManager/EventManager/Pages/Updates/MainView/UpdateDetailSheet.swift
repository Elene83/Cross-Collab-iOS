import SwiftUI

struct UpdateDetailSheet: View {
    let event: UpdateEventDetail
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            SheetHandle()
            
            EventDetailHeader(event: event)
            
            EventActionButtons()
            
            Spacer()
            
            CancelRegistrationButton()
            
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
