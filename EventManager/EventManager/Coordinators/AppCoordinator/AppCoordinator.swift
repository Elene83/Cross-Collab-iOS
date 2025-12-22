//
//  AppCoordinator.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

@MainActor
class AppCoordinator: ObservableObject {
    @Published var isAuthenticated = false
    
    func login() {
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
}
