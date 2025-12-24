import SwiftUI
import MapKit

struct UpcomingEventCard: View {
    let event: Event
    
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
                Text("\(event.startDateTime.formatted(date: .abbreviated, time: .omitted)), \(event.startDateTime.formatted(date: .omitted, time: .shortened)) - \(event.endDateTime.formatted(date: .omitted, time: .shortened))")
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
            
            // Map using UIViewRepresentable
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
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(event.location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                let newCoordinate = location.coordinate
                coordinate = newCoordinate
                region = MKCoordinateRegion(
                    center: newCoordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
}
