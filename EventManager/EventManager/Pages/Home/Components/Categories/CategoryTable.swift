import SwiftUI

struct CategoryTable: View {
    let categories: [Category]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let colors = ["AppViolet", "AppBlue", "AppGreen", "AppGreen", "AppBlue", "AppViolet"]
    
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
                    ForEach(Array(categories.prefix(6).enumerated()), id: \.element.id) { index, category in
                        NavigationLink(value: category) {
                            CategoryCard(category: category, color: colors[index])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
