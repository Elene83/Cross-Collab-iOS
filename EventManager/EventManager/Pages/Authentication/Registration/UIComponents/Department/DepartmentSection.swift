import SwiftUI

struct DepartmentSection: View {
    @Binding var selectedDepartmentId: Int  
    
    private var selectedDepartmentName: String {
        Department.from(id: selectedDepartmentId)?.name ?? "Select Department"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Department")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            
            Menu {
                ForEach(Department.allCases) { department in
                    Button(department.name) {
                        selectedDepartmentId = department.id
                    }
                }
            } label: {
                HStack {
                    Text(selectedDepartmentName)
                        .font(.system(size: 15))
                        .foregroundColor(selectedDepartmentId == 0 ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(height: 48)
                .padding(.horizontal, 16)
                .background(Color(.appBlue).opacity(0.10))
                .cornerRadius(8)
            }
        }
    }
}
