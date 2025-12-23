//
//  ErrorView.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.appRed)
            
            Text("Something went wrong")
                .font(.headline)
                .foregroundColor(.appGray)
            
            Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.appDarkGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: retryAction) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(Color.appViolet)
                    Text("Retry")
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.appViolet)
                .cornerRadius(10)
            }
        }
    }
}
