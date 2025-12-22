//
//  AuthCoordinatorView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @StateObject private var coordinator = AuthCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SignInView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signIn:
                        SignInView()
                    case .registration:
                        RegistrationView()
                    case .forgotPassword:
                        ForgotPasswordView()
                    }
                }
        }
        .environmentObject(coordinator)
    }
}
