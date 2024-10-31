//
//  MotionManager.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    @Published var isShaking = false
    @Published var magnitude = 0.0
    
    init() {
        startAccelerometerUpdates()
    }
    
    func startAccelerometerUpdates() {
        // get the accelerometer's status
        
        guard motionManager.isAccelerometerAvailable else {
            return
        }
            
        // Set the update interval
        
        motionManager.accelerometerUpdateInterval = 0.2
        
        //
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            
            let acceleration = data.acceleration
            self.magnitude = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
            
            // threshold for shaking gesture
            if self.magnitude > 4.0 {
                self.isShaking.toggle()
            } else {
                self.isShaking = false
            }
            
        }
    }
    
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
    
}
