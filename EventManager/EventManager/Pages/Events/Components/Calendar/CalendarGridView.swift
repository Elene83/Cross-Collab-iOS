import SwiftUI

struct CalendarGridView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekDays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: { viewModel.changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
                
                Text(viewModel.monthYearString)
                    .font(.headline)
                
                Spacer()
                
                Button(action: { viewModel.changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Array(viewModel.daysInMonth.enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        DayCell(
                            date: date,
                            isToday: Calendar.current.isDateInToday(date),
                            isSelected: Calendar.current.isDate(date, inSameDayAs: viewModel.selectedDate),
                            hasEvents: viewModel.hasEvents(for: date)
                        )
                        .onTapGesture {
                            viewModel.selectDate(date)
                        }
                    } else {
                        Text("")
                            .frame(height: 36)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}
