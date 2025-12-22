//
//  AppCoordinatorView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some View {
        Group {
            if appCoordinator.isAuthenticated {
                MainTabView()
                    .environmentObject(appCoordinator)
            } else {
                AuthCoordinatorView()
                    .environmentObject(appCoordinator)
            }
        }
    }
}
