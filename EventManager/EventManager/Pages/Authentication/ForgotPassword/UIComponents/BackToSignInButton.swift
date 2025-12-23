//
//  BackToSignInButton.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct BackToSignInButton: View {
    let onBack: () -> Void
    
    var body: some View {
        Button(action: onBack) {
            HStack(spacing: 8) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.appViolet)
                Text("Back to Sign In")
                    .font(.system(size: 16))
            }
            .foregroundColor(.primary)
            .navigationBarBackButtonHidden(true)
        }
    }
}
