//
//  CustomTextFieldStyle.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    var hasError: Bool = false
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(height: 48)
            .background(Color.clear) 
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(hasError ? Color.red : Color.gray.opacity(0.5), lineWidth: 1)
            )
            .foregroundStyle(.primary)
    }
}
