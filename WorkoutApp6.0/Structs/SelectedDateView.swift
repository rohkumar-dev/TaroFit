//
//  SelectedDateView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/26/22.
//

import SwiftUI

struct SelectedDateView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var profile: ProfileManager
    @Binding var selectedDate: Date?
    // Used in dragging
    @State private var curHeight: CGFloat = 0
    @State private var prevDragTranslation = CGSize.zero
    
    let maxHeight = screenHeight * 0.38
    let minHeight = screenHeight * 0.05
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black

        if let date = selectedDate {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(lightColor)
                // Info for selected date (only drawn if selected date != nil
                VStack(alignment: .leading) {
                    // Header to show selected date
                    ZStack(alignment: .top) {
                        Capsule()
                            .frame(width: screenWidth * 0.1, height: screenHeight * 0.005)
                            .padding(.top, 5)
                        
                        
                        HStack {
                            Text(date.formatDate())
                                .font(.system(size: 25, weight: .bold))
            
                            Spacer()
                            
                        }
                        .foregroundColor(darkColor)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(lightColor.opacity(0.00001))
                    .gesture(dragGesture)
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        // Calorie Goal
                        Group {
                            let index = profile.caloriesEatenHistoryDates.firstIndex(of: getDate(date)) ?? -1
                            let calsConsumed = (index < profile.caloriesEatenHistory.count && index != -1) ? profile.caloriesEatenHistory[index] : 0
                            let completedGoal = calsConsumed != 0 && calsConsumed < profile.maintenanceCalories
                            
                            TaskView(wasCompleted: completedGoal, taskName: "Calories Goal", subText: (calsConsumed == 0) ? "No Meals Inputted" : "\(calsConsumed) / \(profile.maintenanceCalories) Calories Consumed")
                        }
                        
                        // Weight goal
                        Group {
                            let index = profile.weightHistoryDates.firstIndex(of: getDate(date)) ?? -1
                            let weight = (index != -1) ? profile.weightHistory[index] : 0
                            let completedGoal = weight != 0
                            
                            TaskView(wasCompleted: completedGoal, taskName: "Weight", subText: (completedGoal ? "\(weight) lbs" : "No Weight Inputted"))
                        }
                        
                        // Core workout goal
                        Group {
                            let index = profile.abWorkoutDates.firstIndex(of: getDate(date)) ?? -1
                            let completedGoal = index != -1
                            
                            TaskView(wasCompleted: completedGoal, taskName: "Core Workout", subText: (completedGoal ? "Workout Completed at \(profile.abWorkoutTimes[index])" : "No Workout Completed"), isLastItemInList: true)
                        }
                        
                        
                        
                        
                    }
                    Spacer()
                }
            }
            .frame(height: self.curHeight)
            .shadow(color: footerColor.opacity(0.1), radius: 20, x: 0, y: -10)
            // Animates view in from bottom of screen
            .transition(.move(edge: .bottom))
            .onAppear {
                withAnimation { self.curHeight = screenHeight * 0.38 }
            }
            
        }
        
    }
    
    struct TaskView: View {
        @Environment(\.colorScheme) var colorScheme
        
        var wasCompleted: Bool
        var taskName: String
        var subText: String
        var isLastItemInList = false
        
        var body: some View {
            let darkColor = colorScheme == .light ? Color.black : .white
            //let lightColor = colorScheme == .light ? Color.white : .black
            
            HStack(alignment: .top) {
                
                VStack(spacing: 0) {
                    Circle()
                        .fill(self.wasCompleted ? .green : .red)
                        .frame(width: screenWidth * 0.02, height: screenWidth * 0.02)
                    Rectangle()
                        .fill(darkColor.opacity(0.5))
                        .frame(width: 1, height: screenHeight * 0.05)
                        .opacity(isLastItemInList ? 0 : 1)
                    
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(self.taskName)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(verbatim: self.subText)
                        .font(.system(size: 10, weight: .regular))
                }
                .offset(y: -screenHeight * 0.01)
                
                
            }
            .frame(idealWidth: screenWidth * 0.5, alignment: .leading)
            .padding(.leading, screenWidth * 0.1)
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTranslation.height
                curHeight -= dragAmount / (curHeight > maxHeight || curHeight < minHeight ? 6 : 1)
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                if curHeight > maxHeight {
                    withAnimation { curHeight = maxHeight }
                } else if curHeight < minHeight {
                    withAnimation { self.selectedDate = nil }
                }
            }
        
    }
    
    
    
}

struct SelectedDateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CalendarView()
                .environmentObject(ProfileManager())
            
            Footer()
                .environmentObject(NavigationManager())
        }
        .preferredColorScheme(.dark)
    }
}
