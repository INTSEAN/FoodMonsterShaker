//
//  LocationManager.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    // Initializing the location
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
}
