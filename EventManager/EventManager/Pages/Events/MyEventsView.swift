import SwiftUI
import MapKit

struct MyEventsView: View {
    @StateObject private var viewModel = MyEventsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                Text("My Events")
                    .font(.title)
                
                Picker("View", selection: $viewModel.selectedView) {
                    Text("List").tag(0)
                    Text("Calendar").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(Color.white)
            
            if viewModel.selectedView == 0 {
                EventListView(events: viewModel.events)
            } else {
                EventCalendarView(viewModel: viewModel)
            }
        }
    }
}

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.isUserInteractionEnabled = true
        
        if let coordinate = coordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        if let coordinate = coordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
}

#Preview {
    MainTabView()
}
