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
    @State private var isTapped = false
    @State private var region: MKCoordinateRegion
    @StateObject var locationManager = LocationManager()
    @State private var selectedDiningHall: DiningHall? = nil // Track selected dining hall


    init() {
           _region = State(initialValue: MKCoordinateRegion(
               center: CLLocationCoordinate2D(latitude: 39.9522, longitude: -75.1932),
               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: viewModel.diningHalls) { diningHall in
            // Create Map Annotation with a non-optional coordinate
            MapAnnotation(coordinate: diningHall.location.coordinate) {
                VStack {
                    Image(systemName: viewModel.isCollected(diningHall) ? "checkmark.circle.fill" : isTapped ? "mappin.circle.fill" : "mappin")
                        .foregroundColor(viewModel.isCollected(diningHall) ? .green : .blue)
                        .onTapGesture {
                            isTapped.toggle()
                            selectedDiningHall = diningHall
                        }
                    Text(diningHall.name)
                        .font(.caption)
                }
            }
        }
        .navigationTitle("Dining Hall Map")
        .navigationDestination(for: DiningHall?.self) { diningHall in
            if let diningHall = diningHall {
                DiningHallView(diningHall: diningHall)
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(DiningHallViewModel())
}
