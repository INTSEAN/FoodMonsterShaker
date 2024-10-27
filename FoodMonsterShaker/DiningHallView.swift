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
    
    @State var locationManager = LocationManager()
    @State var motionManager = MotionManager()
    
    @State private var isWithinRange: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    
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
            locationManager.requestAuthorization()
            locationManager.requestLocation()
        }
        
        // When the information is received
        
        .onReceive(locationManager.$userLocation) {location in
            if let userLocation = location {
                // let distance = userLocation.distance(from: diningHall.location)
                
                // isWithinRange = distance <= 50
            } else {
                isWithinRange = false
            }
        }
        
        
        .onReceive(motionManager.$isShaking) { isShaking in
            // if isShaking && isWithinRange && !viewModel.isCollected(diningHall) {
                // viewModel.collect(diningHall)
            //}
            // alertMessage = "You have collected \(diningHall)"
            showAlert = true
        }
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congratulations"), message: Text(alertMessage), dismissButton: .default(Text("OKAY")))
        }
                  
        // .navigationTitle(diningHall.name)
    }
    
}



#Preview {
    DiningHallView()
}




