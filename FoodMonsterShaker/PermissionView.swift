//
//  PermissionView.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/27/24.
//
import SwiftUI

struct PermissionView: View {
    var onAllow: () -> Void

    var body: some View {
        VStack {
            Text("Location Access Needed")
                .font(.headline)
                .padding()
            Text("We need your location to check if you're near a dining hall.")
                .multilineTextAlignment(.center)
                .padding()
            Button("Allow Location Access") {
                onAllow()
            }
            .padding()
        }
    }
}

