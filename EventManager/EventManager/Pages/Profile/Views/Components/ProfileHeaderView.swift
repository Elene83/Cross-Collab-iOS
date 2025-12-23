import SwiftUI

struct ProfileHeaderView: View {
    let fullName: String
    let profileImageUrl: String?
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 120, height: 120)
                
                if let imageUrl = profileImageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 50))
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.appViolet)
                }
            }
            
            VStack(spacing: 4) {
                Text(fullName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.appDarkGray)
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 32)

    }
}

#Preview {
    ProfileView()
}
