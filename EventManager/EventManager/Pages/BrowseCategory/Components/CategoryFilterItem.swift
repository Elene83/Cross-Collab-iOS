import SwiftUI

struct CategoryFilterItem: View {
    var filterItem: CategoryFilterModel
    
    var body: some View {
        HStack {
            Text(filterItem.label)
                .foregroundStyle(filterItem.isActive ? Color.white : Color("AppDarkGray"))
                .font(.system(size: 14))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(filterItem.isActive ? Color("AppViolet") : Color("AppBlue").opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}
