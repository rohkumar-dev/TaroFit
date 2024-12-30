//
//  CoreWorkoutView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct CoreWorkoutView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var coreManager: CoreWorkoutManager
    @EnvironmentObject var timer: TimerManager
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        VStack(spacing: 0) {
            // Header
            ZStack {
                defaultPurple.opacity(colorScheme == .light ? 1 : 0.65).ignoresSafeArea()

                HStack {
                    // X button to close sheet
                    Button {
                        timer.workoutInProgress = false
                        timer.reset()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Volume button to toggle volume mode
                    Button {
                        timer.volumeEnabled.toggle()
                    } label: {
                        Image(systemName: timer.volumeEnabled ? "speaker.wave.2" : "speaker.slash")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.trailing, timer.volumeEnabled ? 0 : screenWidth * 0.02)
                    }
                    .padding(.horizontal)
                        
                }
  
            }
            .frame(height: screenHeight * 0.05)
            
            ZStack {
                Rectangle()
                    .fill(defaultPurple.opacity(0.5))
                
                if timer.currentExerciseState == .resting {
                    Text("Rest")
                        .foregroundColor(darkColor.opacity(0.7))
                        .font(.system(size: screenWidth * 0.04, weight: .bold))
                        .shadow(color: lightColor.opacity(0.5), radius: 35)
                } else {
                    GifImage(coreManager.getWorkoutArray()[timer.currentExercise])
                        .id(timer.currentExercise)
                }
                
            }
            .frame(height: screenHeight * 0.26)


            
            // Circle progress bar
            HStack {
                // Go back exercise button
                let isFirstExercise = timer.currentExercise <= 0
                Button {
                    timer.decrement()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(darkColor)
                        .font(.system(size: 20))
                }
                .opacity(isFirstExercise ? 0 : 1)
                
                // Circle progress bar
                ZStack {
                    Circle()
                        .stroke(lineWidth: 7)
                        .opacity(0.2)
                        .foregroundColor(.gray)
                    
                    let setLength = timer.currentExerciseState == .working ? timer.setLength : timer.restLength
                    let progress: Double = Double(timer.secondsLeftInSet) / Double(setLength)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(defaultPurple.opacity(colorScheme == .light ? 1 : 0.8))
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.easeInOut(duration: 2), value: progress)
                    
                    Text("\(timer.secondsLeftInSet)")
                        .font(.system(size: screenWidth * 0.18, weight: .thin, design: .rounded))
                        .foregroundColor(darkColor.opacity(0.8))
                }
                .padding(.horizontal)
                .frame(width: screenWidth * 0.7, height: screenWidth * 0.7)
                
                
                // Go forward exercise button
                let isLastExercise = timer.currentExercise >= coreManager.getWorkoutArray().count - 1
                Button {
                    timer.increment()
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(darkColor)
                        .font(.system(size: 20))
                }
                .opacity(isLastExercise ? 0 : 1)
                
            }
            
            // Displays exercise names
            VStack {
                let workout = coreManager.getWorkoutArray()
                
                Text(timer.currentExerciseState == .working ? workout[timer.currentExercise] : "Rest")
                    .foregroundColor(defaultPurple.opacity(colorScheme == .light ? 1 : 0.9))
                    .font(.system(size: screenWidth * 0.06, weight: .medium))
                    .padding(.bottom)
                
                if workout.count > timer.currentExercise+1 {
                    Text("Next: \(workout[timer.currentExercise+1])")
                }
            }
              
            // Progress bar on bottom of screen
            VStack {
                let progress = 1.0 - Double(timer.totalSecondsLeft) / Double(7 * (timer.setLength + timer.restLength) - timer.restLength)
                
                ProgressView(value: progress, total: 1.0)
                    .tint(defaultPurple)
                    .frame(width: screenWidth * 0.85)
                    .padding(.vertical, screenHeight * 0.01)
                
                Text(organizeTimer(timer.totalSecondsLeft))
                    .font(.system(size: 18, weight: .semibold))
                
                Text("left")
                    .font(.system(size: 15))

            
            }
            
            Spacer()
            
        }
    }
}

struct CoreWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        CoreWorkoutView()
            .environmentObject(CoreWorkoutManager())
            .environmentObject(TimerManager())
            .preferredColorScheme(.dark)
    }
}
