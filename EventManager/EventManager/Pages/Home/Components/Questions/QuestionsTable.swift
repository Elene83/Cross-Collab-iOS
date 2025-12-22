import SwiftUI

struct QuestionsTable: View {
    let faqs: [FAQ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Frequently Asked Questions")
                .font(.system(size: 18))
                .foregroundStyle(Color("AppBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if faqs.isEmpty {
                Text("No FAQs available")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(height: 80)
            } else {
                VStack(spacing: 8) {
                    ForEach(faqs.prefix(5)) { faq in
                        QuestionCard(faq: faq)
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
