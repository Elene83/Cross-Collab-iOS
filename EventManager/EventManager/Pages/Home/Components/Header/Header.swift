import SwiftUI

struct Header: View {
    var name: String?
    
    var firstName: String {
        guard let name = name else { return "Sarah" }
        return name.components(separatedBy: " ").first ?? name
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text("Welcome back, \(firstName)")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(Color("AppBlack"))
            Text("Stay connected with upcoming company events and activities.")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color("AppGray"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }
}

