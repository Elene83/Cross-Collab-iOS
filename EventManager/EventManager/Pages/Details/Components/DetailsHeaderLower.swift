import SwiftUI

struct DetailsHeaderLower: View {
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color("AppDarkGray"))
            
            HStack(spacing: 14) {
                Image(systemName: "calendar")
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppGray"))
                    .frame(width: 20, alignment: .leading)
                Text(Formatters.shared.formatStartDateMonth(for: event))
                    .font(.system(size: 15))
                    .foregroundStyle(Color("AppDarkGray"))
            }
            
            HStack(spacing: 14) {
                Image(systemName: "clock")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(width: 20, alignment: .leading)
                Text(Formatters.shared.timeRange(for: event))
                    .font(.system(size: 15))
                    .foregroundStyle(Color("AppDarkGray"))
            }
            
            HStack(spacing: 14) {
                Image(systemName: "location.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(width: 20, alignment: .leading)
                Text(event.location)
                    .font(.system(size: 15))
                    .foregroundStyle(Color("AppDarkGray"))
            }
            
            HStack(spacing: 14) {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(width: 20, alignment: .leading)
                Text("\(event.registeredCount) registered • \(event.spotsRemaining) spots left")
                    .font(.system(size: 15))
                    .foregroundStyle(Color("AppDarkGray"))
            }
        }
    }
}

#Preview {
    MainTabView()
}
