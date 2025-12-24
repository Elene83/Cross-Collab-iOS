import SwiftUI

struct CategoryCard: View {
    let category: Category
    let color: String
    
    var body: some View {
        VStack(spacing: 2) {
            Image(category.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color(color)) 
            
            Text(category.title)
                .font(.system(size: 14))
                .foregroundStyle(Color("AppBlack"))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            Text("\(category.eventCount.count) events")
                .font(.system(size: 12))
                .foregroundStyle(.gray)
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
        .frame(width: 106, height: 122)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    MainTabView()
}
