import SwiftUI

struct DayCell: View {
    let date: Date
    let isToday: Bool
    let isSelected: Bool
    let hasEvents: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.subheadline)
                .foregroundColor(isToday || isSelected ? .white : .primary)
                .frame(width: 36, height: 36)
                .background(isToday || isSelected ? Color("AppViolet") : Color.clear)
                .clipShape(Circle())
            
            if hasEvents && !isToday && !isSelected {
                Circle()
                    .fill(Color("AppViolet"))
                    .frame(width: 4, height: 4)
            } else {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

#Preview {
    MainTabView()
}

