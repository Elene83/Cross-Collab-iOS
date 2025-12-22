import SwiftUI

struct DetailsSpeaker: View {
    var speaker: Speaker
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: speaker.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(speaker.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(speaker.position)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    MainTabView()
}
