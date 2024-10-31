//
//  Circular.swift
//  FoodMonsterShaker
//
//  Created by SEAN DONOVAN on 10/30/24.
//

import SwiftUI

struct CircularView: View {
    var magnitude: CGFloat
    var maxMagnitude: CGFloat
    
    private var progress: CGFloat {
        min(magnitude / maxMagnitude, 1.0)
    }

    var body: some View {
        VStack {
            ZStack {
                // Background Circle
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.red)
                    .frame(width: 100, height: 100)
                
                // Foreground Circle for Progress
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.green)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 100, height: 100)
                    .animation(.easeInOut, value: progress)
                
                // Center Text
                VStack {
                    Text(String(format: "%.1f", magnitude))
                        .font(.largeTitle)
                        .bold()
                    Text("Magnitude")
                        .font(.caption)
                }
            }
            Text("Shake to Collect!")
                .bold()
        }
    }
}


#Preview {
    CircularView(magnitude: 2.7, maxMagnitude: 4.0)
}
