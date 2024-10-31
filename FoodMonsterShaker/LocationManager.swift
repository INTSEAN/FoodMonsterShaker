//
//  LocationManager.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    /// PCC
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    /// Alert Publishing
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    
    // Initializing the location
    override init() {
        super.init()
        locationManager.delegate = self
        
        /// PCC
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Initialize authorization status
        self.authorizationStatus = locationManager.authorizationStatus
    }
    
    /// Purely Class code
    ///
    // Start continuous location updates
    func startUpdatingLocation() {
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    // Stop location updates when not needed
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // Authorization request
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Request Location
    private func requestLocation() {
        locationManager.requestLocation()
    }
    
    // CLLocation Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        switch self.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                self.startUpdatingLocation()
            } else {
                self.alertMessage = "Location services are disabled."
                self.showAlert = true
            }
        case .denied, .restricted:
            /// We want to show the Permission View Here?
            self.alertMessage = "Please enable location in settings"
            self.showAlert = true
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            send(location, to: sketchyServer)
//        }
        self.userLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
        self.alertMessage = "Failed to get location: \(error.localizedDescription)"
        self.showAlert = true
    }
}
