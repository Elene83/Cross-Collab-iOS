import SwiftUI

struct EventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 2) {
                    Text(Formatters.shared.monthAbbreviation(for: event))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color("AppViolet"))
                    Text(Formatters.shared.dayOfMonth(for: event))
                        .font(.system(size: 24))
                        .foregroundStyle(Color("AppViolet"))
                }
                .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(event.title)
                        .font(.system(size: 16))
                        .foregroundStyle(Color("AppBlack"))
                        .lineLimit(2)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 11))
                        Text(Formatters.shared.timeRange(for: event))
                            .font(.system(size: 13))
                    }
                    .foregroundStyle(.gray)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 11))
                        Text(event.location)
                            .font(.system(size: 13))
                            .lineLimit(1)
                    }
                    .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            
            if let description = event.description {
                Text(description)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 62)
            }
            
            Spacer()
                .frame(height: 1)
            
            HStack {
                HStack(spacing: 1) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 11))
                    Text("\(event.registeredCount) registered")
                        .font(.system(size: 12))
                    Text("•")
                    Text("\(event.spotsRemaining) spots left")
                        .font(.system(size: 12))
                }
                .foregroundStyle(.gray)
                
                Spacer()
                
                Button(action: {
                    print("aqac navigacia")
                }) {
                    HStack(spacing: 4) {
                        Text("View Details")
                            .font(.system(size: 13, weight: .medium))
                        Image("rightArrow")
                            .font(.system(size: 11))
                    }
                    .foregroundStyle(Color("AppDarkGray"))
                }
            }
            .padding(.leading, 62)
        }
        .padding(16)
        .frame(height: 174)
        .background(Color("AppBlue").opacity(0.1))
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
    
}

#Preview {
    MainTabView()
}
