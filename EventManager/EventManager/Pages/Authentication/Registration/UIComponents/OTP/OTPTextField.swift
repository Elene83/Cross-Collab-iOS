//
//  OTPTextField.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct OTPTextField: View {
    @Binding var text: String
    @State private var onComplete: () -> Void = { }
    
    var body: some View {
        TextField("", text: $text,)
            .frame(width: 48, height: 56)
            .multilineTextAlignment(.center)
            .font(.system(size: 20, weight: .medium))
            .background(Color(.appBlue).opacity(0.10))
            .cornerRadius(8)
            .keyboardType(.numberPad)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
                if newValue.count == 1 {
                    onComplete()
                }
            }
    }
}
#Preview {
    RegistrationView()
}
