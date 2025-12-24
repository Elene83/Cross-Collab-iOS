import SwiftUI

struct MyEventCard: View {
    let event: Event
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text(viewModel.formatEventDateTime(event.startDateTime, event.endDateTime))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "mappin.circle")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text(event.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "person.2")
                        .foregroundColor(.gray)
                        .frame(width: 16)
                    Text("\(event.registeredCount)/\(event.capacity) registered")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(viewModel.getEventTypeName(for: event.eventTypeId))
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.1))
                .foregroundColor(.primary)
                .cornerRadius(12)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
