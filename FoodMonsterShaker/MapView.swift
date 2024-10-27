//
//  MapView.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    // @EnvironmentObject var viewModel: DiningHallViewModel
    @State private var region: MKCoordinateRegion
    
    init() {
        // Initialize the region to a central location
        _region = State(initialValue: MKCoordinateRegion (
            center: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    
    /// Body View
    ///
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: viewModel.diningHalls) {diningHall in
//            MapAnnotation(coordinate: diningHall.location?.coordinate) {
//                VStack {
//                    Image(systemName: viewModel.isCollected(diningHall) ? "checkmark.circle.fill" : "mappin.circle")
//                        .foregroundColor(viewModel.isCollected(diningHall) ? .green : .red)
//                        .onTapGesture {
//                            /// Handle the tap gesture -> Navigation to Dining Hall View? TODO:
//                        }
//                    Text(diningHall.name)
//                        .font(.caption)
//                }
//            }
//        }
//        .navigationTitle("DINING HALL MAP")
//    }
    
    
}
