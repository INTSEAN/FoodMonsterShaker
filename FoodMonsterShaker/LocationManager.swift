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
    
    @Published var userLocation: CLLocation?
    // Check if the
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    
    // Initializing the location
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Initialize authorization status
        self.authorizationStatus = locationManager.authorizationStatus
    }
    
    // Authorization request
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Request Location
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    // CLLocation Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        // Handle changes if needed
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
}
