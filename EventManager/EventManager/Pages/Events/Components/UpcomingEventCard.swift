import SwiftUI
import MapKit

struct UpcomingEventCard: View {
    let event: Event
    @ObservedObject var viewModel: MyEventsViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var coordinate: CLLocationCoordinate2D?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.headline)
                .fontWeight(.semibold)
            
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
            
            MapViewRepresentable(region: $region, coordinate: coordinate)
                .frame(height: 120)
                .cornerRadius(8)
                .overlay(
                    Text("Map Preview of Event Location")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                )
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
        .onAppear {
            geocodeLocation()
        }
    }
    
    private func geocodeLocation() {
        viewModel.geocodeLocation(for: event.location) { coordinate in
            guard let coordinate = coordinate else { return }
            
            self.coordinate = coordinate
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}
