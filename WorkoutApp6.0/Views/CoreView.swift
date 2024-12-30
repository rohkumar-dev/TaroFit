//
//  CoreView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct CoreView: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var profile: ProfileManager
    
    @StateObject var coreManager = CoreWorkoutManager()
    @StateObject var timer = TimerManager()
    
    @State private var currentDisplayedGif: Int?
    @State private var displayGif = false
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        ZStack {
            defaultPurple.opacity(0.5).ignoresSafeArea()

            ScrollView {
                VStack(spacing: screenHeight * 0.02) {
                    Text("Six Pack Shuffle")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(lightColor)
                        )
                        .shadow(color: footerPurple.opacity(0.3), radius: 10, x: 0, y: 10)
                    
                    ZStack {
                        // White rounded rectangle background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(lightColor)
                            .shadow(color: footerPurple.opacity(0.2), radius: 30, x: 10, y: 30)
                        
                        VStack(spacing: 0) {
                            // Workout duration text
                            let convertDifficultyToDuration = [0.0: "5:30", 1: "7:15", 2: "7:50", 3: "8:30", 4: "8:35"]
                            Text("Workout Duration: \(convertDifficultyToDuration[coreManager.workoutDifficulty] ?? "Unknown")")
                                .font(.system(size: screenHeight * 0.02, weight: .bold))
                                .padding(.vertical, screenHeight * 0.03)
                            
                            // List of exercises
                            let workout = coreManager.getWorkoutArray() // Array of exercises (strings)
                            ForEach(0..<workout.count, id: \.self) { i in
                                
                                // Row for each exercise
                                ZStack {
                                    // Alternates between white and gray background color
                                    i % 2 != 0 ? colorScheme == .light ? .white : .black : colorScheme == .light ? Color.init(white: 0.97) : .white.opacity(0.05)
                                    
                                    HStack {
                                        Text(workout[i])
                                            .font(.system(size: 20))
                                        
                                        Spacer()
                                        
                                        Image(coreManager.getWorkoutArray()[i] + " Medium")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight * 0.06, height: screenHeight * 0.05)
                                            .id(coreManager.getWorkoutArray()[i])
                                            .onTapGesture {
                                                withAnimation { self.currentDisplayedGif = i }
                                            }
                                    }
                                    .padding(.horizontal)
                                }
                                .frame(height: screenHeight * 0.07)
                            }
                            
                            Slider(
                                value: Binding(
                                    // Binds slider to workoutState.workoutDifficulty
                                    get: { coreManager.workoutDifficulty },
                                    set: { newValue in
                                        // Updates workoutDifficulty and workoutFormat on change
                                        coreManager.workoutDifficulty = newValue
                                    }
                                ), in: 0...4, step: 1
                            )
                            .tint(defaultPurple.opacity(colorScheme == .light ? 1 : 0.6))
                            .frame(width: 300)
                            .lineLimit(5)
                            .padding(.top)
                            
                            Text("Difficulty: \(convertWorkoutDifficulty[Int(coreManager.workoutDifficulty)] ?? "")")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.black.opacity(0.6))
                                .padding(.vertical)
                            
                            
                            // Shuffle and play buttons
                            HStack(spacing: screenWidth * 0.15) {
                                // Shuffle button
                                CoreButton(iconName: "shuffle") { coreManager.shuffleWorkout() }
                                
                                // Play button
                                CoreButton(iconName: "play.fill") {
                                    SoundManager.shared.playSound("3 2 1")
                                    sleep(3)
                                    
                                    // Begins workout
                                    timer.workoutInProgress = true
                                    timer.setDifficulty(workoutDifficulty: coreManager.workoutDifficulty)
                                    timer.start()
                                    
                                    
                                    // Updates ab workout dates array
                                    if profile.abWorkoutDates.last != getDate() {
                                        profile.abWorkoutDates.append(getDate())
                                        profile.abWorkoutTimes.append(getDate(format: "hh:mm a"))
                                        updateUserInfo(updatedField: "AbWorkoutDates", info: profile.abWorkoutDates, infoType: [String].self)
                                        updateUserInfo(updatedField: "AbWorkoutTimes", info: profile.abWorkoutTimes, infoType: [String].self)
                                    }
                                }
                            }
                            
                            
                            Spacer()
                        }
                        
                    }
                    .frame(width: screenWidth * 0.95, height: screenHeight * 0.77)

                    
                    
                    Spacer()
                }
                .foregroundColor(darkColor)
            }
            
        }
        .overlay (
            // Displays ab exercise gif if user clicks on gif
            AbExerciseView(currentDisplayedGif: self.$currentDisplayedGif)
                .id(self.displayGif)
                .environmentObject(coreManager)
        )
        .fullScreenCover(isPresented: $timer.workoutInProgress) {
            CoreWorkoutView()
                .environmentObject(coreManager)
                .environmentObject(timer)
        }
    }
}

struct CoreView_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
            .environmentObject(ProfileManager())
            .preferredColorScheme(.dark)
    }
}
