//
//  HomeView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/24/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navInfo: NavigationManager
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        
        ZStack {
            defaultPurple.opacity(0.5).ignoresSafeArea()
            // All info in view
            ScrollView {
                VStack {
                    // Header
                    ZStack {
                        // Profile pic button
                        HStack {
                            Button {
                                withAnimation {
                                    navInfo.showSettingsView = true
                                    navInfo.currentTab = -1
                                }
                            } label : {
                                ProfilePic(radius: screenWidth * 0.1)
                                    .padding(.leading)
                                    .environmentObject(profile)
                            }
                            
                            Spacer()
                        }
                        
                        
                        Text(getDate(format: "MMMM dd, yyyy"))
                            .font(.system(size: 16, weight: .bold))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(lightColor)
                            )
                            .shadow(color: footerPurple.opacity(0.3), radius: 10, x: 0, y: 10)
                        
                    }
                    
                    // Main info view
                    ZStack {
                        // White rounded rectangle background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(lightColor)
                            .shadow(color: footerPurple.opacity(0.2), radius: 30, x: 10, y: 30)
                        
                        
                        
                        VStack(spacing: 0) {
                            // Calorie chart button
                            Button {
                                withAnimation { navInfo.showMealEntrySheet = true }
                            } label: {
                                // Calorie chart
                                ZStack {
                                    let progress = Double(profile.caloriesEatenHistory.last ?? 0) / Double(profile.maintenanceCalories)
                                    
                                    Circle()
                                        .trim(from: 0.0, to: 0.6)
                                        .stroke(.gray.opacity(colorScheme == .light ? 0.1 : 0.25), style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(Angle(degrees: -198))
                                    
                                    Circle()
                                        .trim(from: 0.0, to: min(progress * 0.6, 0.6))
                                        .stroke(progress > 1 ? .red.opacity(0.4) : .green.opacity(0.6), style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(Angle(degrees: -198))
                                        .animation(.easeInOut(duration: 1), value: progress)
                                    
                                    VStack {
                                        Text(verbatim: "\(profile.maintenanceCalories - (profile.caloriesEatenHistory.last ?? 0))")
                                            .font(.system(size: screenWidth * 0.14, weight: .semibold, design: .rounded))
                                        
                                        Text("calories left")
                                            .font(.system(size: screenWidth * 0.03, weight: .light))
                                    }
                                    .foregroundColor(darkColor)
                                    
                                }
                                .frame(height: screenWidth * 0.7)
                                .padding(.top, screenHeight * 0.05)
                            }
                            
                            
                            // Todo list
                            Text("Today's Goals")
                                .font(.system(size: screenWidth * 0.05, weight: .semibold))
                                .padding(.bottom)
                            
                            
                            HStack {
                                
                                HomeButton("salad", buttonText: "Track a Meal", isCompleted: profile.caloriesEatenHistory.last ?? 0 > 0) {
                                    navInfo.showMealEntrySheet = true
                                }
                                
                                HomeButton("weightscale", buttonText: "Enter Weight", isCompleted: profile.weightHistoryDates.last ?? "" == getDate()) {
                                    navInfo.showWeightEntrySheet = true
                                }
                                
                                HomeButton("core", buttonText: "Train your Core", isCompleted: profile.abWorkoutDates.last ?? "" == getDate()) {
                                    navInfo.currentTab = 3 // Opens core tab
                                }
                            }
                            .padding(.top)
                            
                            Spacer()
                            
                            
                            
                            
                            
                        }
                        .frame(width: screenWidth * 0.7)
                        
                    }
                    .frame(width: screenWidth * 0.95, height: screenHeight * 0.77)
                    
                    Spacer()
                }
            }
        }
        .foregroundColor(darkColor)
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
    
}
