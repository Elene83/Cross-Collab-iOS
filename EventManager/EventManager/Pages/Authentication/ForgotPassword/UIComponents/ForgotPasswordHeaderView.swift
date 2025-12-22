//
//  ForgotPasswordHeaderView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct ForgotPasswordHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Forgot Password")
                .font(.system(size: 32, weight: .semibold))
            
            Text("Enter your email and we'll send you a link to reset your password.")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
}
