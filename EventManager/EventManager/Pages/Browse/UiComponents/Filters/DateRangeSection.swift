import SwiftUI

struct DateRangeSection: View {
    @Binding var selectedDateRange: DateRange
    
    var body: some View {
        Section("Date Range") {
            Picker("Date Range", selection: $selectedDateRange) {
                ForEach(DateRange.allCases, id: \.self) { range in
                    Text(range.displayName).tag(range)
                }
            }
            .pickerStyle(.menu)
            .foregroundStyle(Color.appGray)
        }
    }
}
