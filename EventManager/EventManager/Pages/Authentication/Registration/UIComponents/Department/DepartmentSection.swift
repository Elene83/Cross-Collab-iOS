import SwiftUI

struct DepartmentSection: View {
    @Binding var selectedDepartmentId: Int
    var departments: [Department]
    
    private var selectedDepartmentName: String {
        departments.first(where: { $0.id == selectedDepartmentId })?.name ?? "Select Department"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Department")
                .font(.system(size: 14))
                .foregroundColor(.primary)
            
            Menu {
                if departments.isEmpty {
                    Text("Loading departments...")
                } else {
                    ForEach(departments) { department in
                        Button(department.name) {
                            selectedDepartmentId = department.id
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedDepartmentName)
                        .font(.system(size: 15))
                        .foregroundColor(selectedDepartmentId == 0 ? .gray : .primary)
                    
                    Spacer()
                    
                    if departments.isEmpty {
                        ProgressView()
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: 48)
                .padding(.horizontal, 16)
                .background(Color.appBlue.opacity(0.10)) 
                .cornerRadius(8)
            }
        }
    }
}
