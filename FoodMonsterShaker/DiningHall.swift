//
//  DiningHall.swift
//  FoodMonsterShaker
//
//  Created by Ambika Bhargava on 29/10/24.
//


//This is the DATA MODEL


import Foundation
import CoreLocation

struct DiningHall: Identifiable {
    var id = UUID() // Automatically generated ID
    var name: String
    var location: CLLocation
    var isCollected: Bool = false
}



