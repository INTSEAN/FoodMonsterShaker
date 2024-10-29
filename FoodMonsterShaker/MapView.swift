//
//  MapView.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//
import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: DiningHallViewModel // Access the view model
    @State private var region: MKCoordinateRegion

    init() {
        // Initialize the region to a central location (Penn's location for example)
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.9522, longitude: -75.1932), // Penn's Location Coordinates
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.diningHalls) { diningHall in
            // Create Map Annotation with a non-optional coordinate
            MapAnnotation(coordinate: diningHall.location.coordinate) {
                VStack {
                    Image(systemName: viewModel.isCollected(diningHall) ? "checkmark.circle.fill" : "mappin.circle")
                        .foregroundColor(viewModel.isCollected(diningHall) ? .green : .red)
                        .onTapGesture {
                            // Handle the tap gesture for navigation or showing details (Optional)
                        }
                    Text(diningHall.name)
                        .font(.caption)
                }
            }
        }
        .navigationTitle("DINING HALL MAP")
    }
}

#Preview {
    MapView()
        .environmentObject(DiningHallViewModel()) // Inject mock ViewModel for preview
}
