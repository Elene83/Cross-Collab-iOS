//
//  OTPSection.swift
//  EventManager
//
//  Created by Atinati on 20.12.25.
//

import SwiftUI

struct OTPSection: View {
    @Binding var otpCode: [String]
    @Binding var timeRemaining: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 4) {
                Image("OtpIcon")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("Enter OTP Code")
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
            }
            
            HStack(spacing: 12) {
                ForEach(0..<6, id: \.self) { index in
                    OTPTextField(text: $otpCode[index])
                }
            }
            
            HStack {
                Text("Code expires in 00:\(String(format: "%02d", timeRemaining))")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Spacer()
                Button("Resend Code") {}
                    .font(.system(size: 13))
                    .foregroundColor(.primary)
            }
        }
    }
}
