//
//  SignUpPromptView.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct SignUpPromptView: View {
    let onSignUp: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Button("Sign up", action: onSignUp)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}
