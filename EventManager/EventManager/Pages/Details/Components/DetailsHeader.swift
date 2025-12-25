import SwiftUI

struct DetailsHeader: View {
    var imageUrl: String?
    var eventTypeId: Int
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .overlay(
                            ProgressView()
                        )
                }
                .frame(maxWidth: .infinity)
                .frame(height: 240)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color("AppViolet").opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    )
            }
            
            if let eventType = Category.EventType(rawValue: eventTypeId) {
                Text(eventType.title)
                    .font(.system(size: 12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color("AppViolet").opacity(0.3))
                    .foregroundColor(Color("AppBlack"))
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    MainTabView()
}
