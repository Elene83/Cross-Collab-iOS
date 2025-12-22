import SwiftUI

struct TrendingTable: View {
    let events: [Event]
    
    var trendingEvents: [Event] {
        events.sorted { $0.registeredCount > $1.registeredCount }.prefix(10).map { $0 }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Trending Events")
                    .font(.system(size: 18))
                    .foregroundStyle(Color("AppBlack"))
                
                Spacer()
                
            }
            Text("Popular events with high registration rates")
                .font(.system(size: 16))
                .foregroundStyle(Color("AppGray"))
            
            if trendingEvents.isEmpty {
                Text("No trending events")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(height: 80)
                    .padding(.horizontal, 16)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(trendingEvents) { event in
                                NavigationLink(value: event) {
                                TrendingCard(event: event)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
