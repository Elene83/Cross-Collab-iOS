import SwiftUI

struct DetailsAbout: View {
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("About this event")
                .font(.system(size: 20))
                .foregroundStyle(Color("AppBlack"))
            Text(description)
                .font(.system(size: 14))
                .foregroundStyle(Color("AppDarkGray"))
                .lineSpacing(1.5)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    MainTabView()
}
