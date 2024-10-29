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
            List(viewModel.diningHalls) { hall in
                NavigationLink(destination: DiningHallView(diningHall: hall)) {
                    HStack {
                        Text(hall.name)
                            .font(.headline)
                        Spacer()
                        // Circle indicator
                        Circle()
                            .fill(hall.isCollected ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        // Checkmark for collected halls
                        if hall.isCollected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("Food Monster Shaker")
        }
    }
}

#Preview {
    Home()
        .environmentObject(DiningHallViewModel()) // Mock ViewModel for preview
}
