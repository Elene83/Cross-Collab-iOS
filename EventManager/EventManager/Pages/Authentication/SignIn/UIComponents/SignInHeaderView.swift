//
//  SignInHeaderView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct SignInHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Sign In")
                .font(.system(size: 28, weight: .semibold))
            Text("Enter your credentials to access your account")
                .font(.system(size: 15))
                .foregroundColor(.appDarkGray)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
    }
}

#Preview {
    SignInView()
}
