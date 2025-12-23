import SwiftUI

@MainActor
class AuthCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: AuthRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
