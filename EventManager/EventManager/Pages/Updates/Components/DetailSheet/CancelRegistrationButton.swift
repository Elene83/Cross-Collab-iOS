//
//  CancelRegistrationButton.swift
//  EventManager
//
//  Created by Atinati on 21.12.25.
//

import SwiftUI

struct CancelRegistrationButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Cancel Registration")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.appViolet)
                .cornerRadius(12)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
    }
}

#Preview {
    CancelRegistrationButton()
}
