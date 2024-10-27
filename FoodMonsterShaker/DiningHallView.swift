//
//  DiningHallView.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//

import SwiftUI
import CoreLocation

struct DiningHallView: View {
    // @EnvironmentObject var viewModel : DiningHallViewModel
    
    // var diningHall: DiningHall
    
    @StateObject var locationManager = LocationManager()
    @StateObject var motionManager = MotionManager()
    
    @State private var isWithinRange: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State private var showPermissionSheet = false
    
    
    var body: some View {
        VStack {
            // if a dining hall is collected, tell the user they collected it
            Text("You collected Commons!")
                .font(.largeTitle)
                .padding()
            // Otherwise:
            // Give them info that they haven't collected a dinign hall yet
            
            // Tell them the distance at which a dining hall collection is valid
            
            // Tell the user the action they need to do to collect it
        }
        
        .onAppear() {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                showPermissionSheet = true
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            case .denied, .restricted:
                Alert(title: Text("Location Access Denied"), message: Text("Please enable location access the app location features."), dismissButton: .default(Text("OK")))
                break
            @unknown default:
                break
            }
        }
        
        
//        .onReceive(locationManager.$authorizationStatus) {status in
//            if status == .authorizedWhenInUse || status == .authorizedAlways {
//                locationManager.requestLocation()
//            }
//        }
        
        .onReceive(locationManager.$userLocation) {location in
            if let userLocation = location {
                // let distance = userLocation.distance(from: diningHall.location)
                
                // isWithinRange = distance <= 50
            } else {
                isWithinRange = false
            }
        }
        
        
        
        
        
//        .onReceive(motionManager.$isShaking) { isShaking in
//            if isShaking && isWithinRange && !viewModel.isCollected(diningHall) {
//                viewModel.collect(diningHall)
//                alertMessage = "You've collected \(diningHall.name)!"
//                showAlert = true
//            } else if isShaking && !isWithinRange {
//                alertMessage = "You need to be within 50 meters to collect this dining hall."
//                showAlert = true
//            } else if isShaking && viewModel.isCollected(diningHall) {
//                alertMessage = "You've already collected this dining hall."
//                showAlert = true
//            }
//        }
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congratulations"), message: Text(alertMessage), dismissButton: .default(Text("OKAY")))
        }
        
        .sheet(isPresented: $showPermissionSheet) {
            PermissionView {
                // When the user taps "Allow Location Access"
                showPermissionSheet = false
                locationManager.requestAuthorization()
            }
        }
                  
        // .navigationTitle(diningHall.name)
    }
    
}



#Preview {
    DiningHallView()
}




