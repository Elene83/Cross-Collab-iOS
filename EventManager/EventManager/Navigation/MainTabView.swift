import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", image: "HomeIcon")
                }
                .tag(0)
            BrowseView()
                .tabItem {
                    Label("Browse", image: "BrowseIcon")
                }
                .tag(1)
            EventsView()
                .tabItem {
                    Label("My Events", image: "EventsIcon")
                }
                .tag(2)
            UpdatesView()
                .tabItem {
                    Label("Updates", image: "UpdatesIcon")
                }
                .tag(3)
            ProfileView()
                .tabItem {
                    Label("Profile", image: "ProfileIcon")
                }
                .tag(4)
        }
    }
}
