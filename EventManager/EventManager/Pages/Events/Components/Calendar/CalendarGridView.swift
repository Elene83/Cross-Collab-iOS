struct CalendarGridView: View {
    let events: [Event]
    @Binding var selectedDate: Date
    
    @State private var currentMonth = Date()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekDays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }
    
    var daysInMonth: [Date?] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: currentMonth),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }
        
        var days: [Date?] = []
        var currentDate = monthFirstWeek.start
        
        while days.count < 42 {
            if Calendar.current.isDate(currentDate, equalTo: currentMonth, toGranularity: .month) {
                days.append(currentDate)
            } else {
                days.append(nil)
            }
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return days
    }
    
    func hasEvents(for date: Date) -> Bool {
        events.contains { Calendar.current.isDate($0.startDateTime, inSameDayAs: date) }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Month navigation
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
                
                Text(monthYearString)
                    .font(.headline)
                
                Spacer()
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            
            // Weekday headers
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            
            // Calendar days
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        DayCell(
                            date: date,
                            isToday: Calendar.current.isDateInToday(date),
                            isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                            hasEvents: hasEvents(for: date)
                        )
                        .onTapGesture {
                            selectedDate = date
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
    
    private func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}
