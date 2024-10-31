//
//  FoodMonsterShakerApp.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/24/24.
//

import SwiftUI

@main
struct FoodMonsterShakerApp: App {
    @StateObject private var viewModel = DiningHallViewModel()

    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(viewModel) 
        }
    }
}
