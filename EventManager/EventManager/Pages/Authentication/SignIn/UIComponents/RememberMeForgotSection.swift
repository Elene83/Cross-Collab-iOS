//
//  RememberMeForgotSection.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct RememberMeForgotSection: View {
    @Binding var rememberMe: Bool
    let onForgotPassword: () -> Void
    
    var body: some View {
        HStack {
            Button(action: { rememberMe.toggle() }) {
                HStack(spacing: 8) {
                    Image(systemName: rememberMe ? "checkmark.square" : "square")
                        .font(.system(size: 18))
                        .foregroundColor(rememberMe ? .appViolet : .gray)
                    Text("Remember me")
                        .font(.system(size: 14))
                        .foregroundColor(.appDarkGray)
                }
            }
            
            Spacer()
            
            Button("Forgot password?", action: onForgotPassword)
                .font(.system(size: 14))
                .foregroundColor(.appDarkGray)
        }
    }
}
