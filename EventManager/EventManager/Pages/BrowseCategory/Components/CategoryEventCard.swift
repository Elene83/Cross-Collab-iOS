import SwiftUI

struct CategoryEventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: event.imageUrl.flatMap { URL(string: $0) }) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color("AppGray").opacity(0.3)
                        .overlay(
                            Text("Event Image: Team Building Summit")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        )
                }
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(event.title)
                        .font(.system(size: 16))
                        .foregroundStyle(Color("AppBlack"))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if event.spotsRemaining > 0 {
                        Text("\(event.spotsRemaining) spots left")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color("AppDarkGray"))
                            .padding(8)
                            .background(Color("AppLightGray").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    if let description = event.description {
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                            .frame(width: 20)
                        
                        Text(Formatters.shared.formattedDateCard(for: event))
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                    }
                    
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                            .frame(width: 20)
                        
                        Text(Formatters.shared.timeRange(for: event))
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                    }
                    
                    HStack(spacing: 8) {
                        Image(systemName: "location")
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                            .frame(width: 20)
                        
                        Text(event.location)
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                            .lineLimit(1)
                    }
                }
            }
            .padding(16)
            
            Divider()
                .padding(.horizontal, 16)
            
            Button(action: {
                //see details
            }) {
                Text("View Details")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

#Preview {
    MainTabView()
}
