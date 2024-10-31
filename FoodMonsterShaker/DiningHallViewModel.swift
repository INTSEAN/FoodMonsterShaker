//
//  DiningHallViewModel.swift
//  FoodMonsterShaker
//
//  Created by Ambika Bhargava on 29/10/24.
//


//THIS IS THE VIEW MODEL


import SwiftUI
import Combine
import CoreLocation

class DiningHallViewModel: ObservableObject {
    @Published var diningHalls: [DiningHall] = [
        DiningHall(name: "1920 Commons", location: CLLocation(latitude: 39.95248, longitude: -75.19938)),
        DiningHall(name: "Accenture Café", location: CLLocation(latitude: 39.95202, longitude: -75.19135)),
        DiningHall(name: "Falk at Penn Hillel", location: CLLocation(latitude: 39.95314, longitude: -75.20015)),
        DiningHall(name: "Hill House", location: CLLocation(latitude: 39.95300, longitude: -75.19071)),
        DiningHall(name: "Houston Market", location: CLLocation(latitude: 39.95091, longitude: -75.19388)),
        DiningHall(name: "Joe's Café", location: CLLocation(latitude: 39.95156, longitude: -75.19652)),
        DiningHall(name: "Kings Court English House", location: CLLocation(latitude: 39.95416, longitude: -75.19418)),
        DiningHall(name: "Lauder House", location: CLLocation(latitude: 39.95382, longitude: -75.19108)),
        DiningHall(name: "McClelland (now Penn Dining Sushi Spot)", location: CLLocation(latitude: 39.95107, longitude: -75.19839)),
        DiningHall(name: "Pret a Manger (Locust Walk)", location: CLLocation(latitude: 39.95263, longitude: -75.19848)),
        DiningHall(name: "Quaker Kitchen", location: CLLocation(latitude: 39.95354, longitude: -75.20198)),
    ]
    
    func isCollected(_ hall: DiningHall) -> Bool {
        return hall.isCollected
    }
    
    // Collects the dining hall
    func collect(_ hall: DiningHall) {
        if let index = diningHalls.firstIndex(where: { $0.id == hall.id }) {
            diningHalls[index].isCollected = true
        }
    }
}

