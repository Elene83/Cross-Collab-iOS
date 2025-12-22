import SwiftUI

struct CategoryTable: View {
    let categories: [Category]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Browse By Category")
                .font(.system(size: 18))
                .foregroundStyle(Color("AppBlack"))
            
            if categories.isEmpty {
                Text("No categories available")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(height: 80)
            } else {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(categories.prefix(6)) { category in
                        CategoryCard(category: category)
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
