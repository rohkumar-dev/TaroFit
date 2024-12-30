//
//  NutritionView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI
import SwiftUICharts

struct NutritionView: View {
    @EnvironmentObject var profile: ProfileManager
    
    
    var body: some View {
        VStack {
            
            Header(headerText: "Nutrition")
            
            Spacer()
            
            // Calorie chart
            ZStack {
                
                let progress: Double = Double(profile.caloriesEatenHistory.last ?? 0) / Double(profile.maintenanceCalories)
                
                // Unfilled circle (represents calories left)
                Circle()
                    .stroke(lineWidth: 15)
                    .foregroundColor(.black.opacity(0.05))
                
                
                // Filled circle (represents calories consumed)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(progress < 1.0 ? defaultPurple : .red)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.easeInOut(duration: 2), value: progress)
                VStack {
                    // TODO: CONNECT TO BACKEND
                    let caloriesLeft = profile.maintenanceCalories - (profile.caloriesEatenHistory.last ?? 0)
                    
                    
                    Text("\(caloriesLeft)")
                        .font(.system(size: screenWidth * 0.1, weight: .bold))
                    Text("calories left")
                        .font(.system(size: 15))
                }
            }
            .padding()
            .frame(width: screenWidth * 0.6, height: screenWidth * 0.6)
            
            
            Spacer()
        }
    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
            .environmentObject(ProfileManager())
    }
}
