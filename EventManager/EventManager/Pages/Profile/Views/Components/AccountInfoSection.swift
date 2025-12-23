import SwiftUI

struct AccountInfoSection: View {
    let email: String
    let department: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Account Information")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.appDarkGray)
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                AccountInfoRow(
                    icon: "envelope",
                    label: "Email",
                    value: email
                )
                
                AccountInfoRow(
                    icon: "building.2",
                    label: "Department",
                    value: department
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 16)
    }
}
