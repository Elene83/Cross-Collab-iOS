import SwiftUI

struct QuestionCard: View {
    let faq: FAQ
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(faq.question)
                .font(.system(size: 15))
                .foregroundStyle(Color("AppBlack"))
            
            Text(faq.answer)
                .font(.system(size: 14))
                .foregroundStyle(Color("AppGray"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
    }
}

#Preview {
    MainTabView()
}
