import SwiftUI

struct EventsTable: View {
    let events: [Event] 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Upcoming Events")
                    .font(.system(size: 18))
                    .foregroundStyle(Color("AppBlack"))
                Spacer()

                Text("View All")
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppDarkGray"))
                    .onTapGesture {
                        print("browse eventebi var")
                    }
            }
            
            if events.isEmpty {
                Text("No upcoming events")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(height: 80)
            } else {
                VStack(spacing: 18) {
                    ForEach(events.prefix(3)) { event in
                        NavigationLink(value: event) {
                            EventCard(event: event)
                        }
                        .toolbar {
                            
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

