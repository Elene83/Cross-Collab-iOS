import SwiftUI

struct Header: View {
    var name: String?
    var body: some View {
        
        VStack (alignment: .leading, spacing: 8) {
            //aq saxelis check daamate ro ar iyos imaze didi vidre sachiroa
            Text("Welcome back, \(name ?? "Sarah")")
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

#Preview {
    MainTabView()
}
