import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "AppViolet")?.withAlphaComponent(0.6)
    }
    
    var body: some View {
        TabView(selection: $appCoordinator.selectedTab) {
            HomeView(vm: HomeView.ViewModel())
                .tabItem {
                    Label("Home", image: "HomeIcon")
                }
                .tag(0)
            
            BrowseView()
                .tabItem {
                    Label("Browse", image: "BrowseIcon")
                }
                .tag(1)
            
            MyEventsView()
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
        .tint(Color("AppViolet"))
        .onChange(of: appCoordinator.selectedTab) { oldValue, newValue in
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppCoordinator())
}
