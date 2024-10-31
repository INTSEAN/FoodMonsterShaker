

import SwiftUI
import CoreLocation

struct DiningHallView: View {
    @EnvironmentObject var viewModel: DiningHallViewModel
    var diningHall: DiningHall

    @StateObject var locationManager = LocationManager()
    @StateObject var motionManager = MotionManager()

    @State private var isWithinRange: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var hasCollected: Bool = false

    var body: some View {
        VStack {
            GeometryReader { geometry in
               Text(diningHall.name)
                   .font(.system(.largeTitle, design: .rounded))
                   .padding()
                   .foregroundStyle(.black)
                   .frame(width: geometry.size.width, height: 80)
                   .background(Rectangle().fill(.white))
            }

            if hasCollected || viewModel.isCollected(diningHall) {
                Text("You've already collected this dining hall!")
                    .foregroundColor(.green)
            }
            
            if isWithinRange {
                GeometryReader { geometry in
                    Text("You are within range!")
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 60)
                        .background(Rectangle().fill(.green))
                }
            } else if !isWithinRange {
                GeometryReader { geometry in
                    Text("You need to be within 50 meters to collect \(diningHall.name).")
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 80)
                        .background(Rectangle().fill(.red))
                }
            }
            
            if let userLocation = locationManager.userLocation {

                // Magnitude Display
                
                Text("Shake Intensity")
                    .font(.system(.largeTitle, design: .rounded))
  
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Capsule().fill(.black))
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)
                
                CircularView(magnitude: motionManager.magnitude, maxMagnitude: 4.0)
                
                GeometryReader {geometry in
                    Text("Distance To \(diningHall.name)")
                        .padding(.bottom)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: geometry.size.width, height: 90)
                        .background(Rectangle().fill(.white))
                }
                Text(calculateDistanceFromHall(userLocation, diningHall.location))
                    .font(.system(.largeTitle, design: .rounded))

                    .foregroundColor(.white)
                    .frame(width: 180, height: 180)
                    .background(Circle().fill(isWithinRange ? .green : .red))
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)

            }
            
        }
        
        .onAppear {
            locationManager.requestAuthorization()
            hasCollected = viewModel.isCollected(diningHall)
        }
        
        .onReceive(locationManager.$userLocation) { location in
            if let userLocation = location {
                let distance = userLocation.distance(from: diningHall.location)
                isWithinRange = distance <= 50
            } else {
                isWithinRange = false
            }
        }
        
        .onReceive(motionManager.$isShaking) { isShaking in
            if isShaking && isWithinRange && !viewModel.isCollected(diningHall) {
                collectDiningHall()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congratulations"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func collectDiningHall() {
        if !hasCollected {
            viewModel.collect(diningHall)
            hasCollected = true
            alertMessage = "You've collected \(diningHall.name)!"
            showAlert = true
        }
    }
}

func calculateDistanceFromHall(_ userLocation: CLLocation, _ diningHallLocation: CLLocation) -> String {
    let distance = userLocation.distance(from: diningHallLocation)
    return String(format: "%.2f m", distance)
}


#Preview {
    DiningHallView(diningHall: DiningHall(name: "1920 Commons", location: CLLocation(latitude: 39.9522, longitude: -75.1932)))
        .environmentObject(DiningHallViewModel())
}
