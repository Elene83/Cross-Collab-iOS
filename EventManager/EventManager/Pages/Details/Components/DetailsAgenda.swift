import SwiftUI

struct DetailsAgenda: View {
    var agenda: [EventAgenda]
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(Array(agenda.enumerated()), id: \.element.id) { index, item in
                HStack(alignment: .top, spacing: 16) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(Color("AppBlue").opacity(0.7))
                            .frame(width: 1, height: 45)
                            .offset(y: 35)
                            .opacity(index == agenda.count - 1 ? 0 : 1)
                        
                        Text("\(index + 1)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppBlack"))
                            .frame(width: 26, height: 26)
                            .background(Color("AppBlue").opacity(0.4))
                            .clipShape(Circle())
                    }
                    .frame(width: 26, height: 56)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("AppDarkGray"))
                        
                        Text(item.description)
                            .font(.system(size: 14))
                            .foregroundStyle(Color("AppGray"))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
