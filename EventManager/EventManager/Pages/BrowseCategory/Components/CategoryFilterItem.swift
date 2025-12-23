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
        .background(filterItem.isActive ? Color("AppBlack") : Color("AppLightGray").opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}
