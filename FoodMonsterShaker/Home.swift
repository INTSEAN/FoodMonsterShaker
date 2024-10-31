//
//  Home.swift
//  FoodMonsterShaker
//
//  Created by Ambika Bhargava on 29/10/24.
//


import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: DiningHallViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.diningHalls.sorted { $0.isCollected && !$1.isCollected}) { diningHall in
                NavigationLink(destination: DiningHallView(diningHall: diningHall)) {
                    HStack {
                        Text(diningHall.name)
                            .font(.headline)
                        Spacer()
                        Circle()
                            .fill(diningHall.isCollected ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        if diningHall.isCollected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
    
                        }
                    }
                }
            }
            .navigationTitle("Food Monster Shaker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MapView()) {
                        VStack {
                            Image(systemName: "map")
                                .imageScale(.large)
                                .foregroundStyle(.green)
                            Text("Map")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
        .environmentObject(DiningHallViewModel())
}
