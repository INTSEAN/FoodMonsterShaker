

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

    var body: some View {
        VStack {
            Text(diningHall.name)
                .font(.largeTitle)
                .padding()

            if viewModel.isCollected(diningHall) {
                Text("You've already collected this dining hall!")
                    .foregroundColor(.green)
            } else if isWithinRange {
                Text("You are within range!")
                    .foregroundColor(.blue)

                Button("Collect") {
                    if !viewModel.isCollected(diningHall) {
                        viewModel.collect(diningHall)
                        alertMessage = "You've collected \(diningHall.name)!"
                        showAlert = true
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Text("You need to be within 50 meters to collect this dining hall.")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            locationManager.requestLocation()
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
                viewModel.collect(diningHall)
                alertMessage = "You've collected \(diningHall.name)!"
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Congratulations"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    DiningHallView(diningHall: DiningHall(name: "1920 Commons", location: CLLocation(latitude: 39.9522, longitude: -75.1932)))
        .environmentObject(DiningHallViewModel()) // Mock ViewModel for preview
}
