//
//  OldCoreView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/31/22.
//

import Foundation

//VStack {
//    // Header
//    ZStack {
//        Header(headerText: "Six Pack Shuffle")
//        // Draws checkmark in header if user has done ab workout today
//        if profile.abWorkoutDates.last == getDate() {
//            HStack {
//                Spacer()
//
//                Image(systemName: "checkmark.circle.fill")
//                    .font(.system(size: screenWidth * 0.07))
//                    .foregroundColor(.green.opacity(0.9))
//                    .shadow(color: shadowColor.opacity(0.7), radius: 20)
//                    .background(.white)
//                    .cornerRadius(100)
//                    .padding(.trailing)
//
//            }
//        }
//    }
//
//
//    // List of exercises
//    let workout = coreManager.getWorkoutArray() // Array of exercises (strings)
//    ForEach(0..<workout.count, id: \.self) { i in
//
//        // Row for each exercise
//        ZStack {
//            // Alternates between white and gray background color
//            i % 2 != 0 ? Color.white : Color.init(white: 0.98)
//
//            HStack {
//                Text(workout[i])
//                    .font(.system(size: 20))
//
//                Spacer()
//
//                GifImage(coreManager.getWorkoutArray()[i])
//                    .id(coreManager.getWorkoutArray()[i])
//                    .frame(width: screenHeight * 0.05, height: screenHeight * 0.05)
//                    .onTapGesture {
//                        withAnimation {
//                            self.currentDisplayedGif = i
//                        }
//                    }
//            }
//            .padding()
//        }
//        .frame(height: screenHeight * 0.07)
//    }
//
//    // Difficulty Slider
//    VStack {
//        Slider(
//            value: Binding(
//                // Binds slider to workoutState.workoutDifficulty
//                get: { coreManager.workoutDifficulty },
//                set: { newValue in
//                    // Updates workoutDifficulty and workoutFormat on change
//                    coreManager.workoutDifficulty = newValue
//                }
//            ), in: 0...4, step: 1
//        )
//        .tint(defaultPurple)
//        .frame(width: 300)
//        .lineLimit(5)
//        .padding(.top)
//
//        Text("Difficulty: \(convertWorkoutDifficulty[Int(coreManager.workoutDifficulty)] ?? "")")
//            .font(.system(size: 12, weight: .semibold))
//            .foregroundColor(.black.opacity(0.6))
//    }
//
//    Spacer()
//
//    // Shuffle and play buttons
//    HStack(spacing: screenWidth * 0.15) {
//        // Shuffle button
//        CoreButton(iconName: "shuffle") { coreManager.shuffleWorkout() }
//
//        // Play button
//        CoreButton(iconName: "play.fill") {
//            // Begins workout
//            timer.workoutInProgress = true
//            timer.setDifficulty(workoutDifficulty: coreManager.workoutDifficulty)
//            timer.start()
//
//            // Updates ab workout dates array
//            if profile.abWorkoutDates.last != getDate() {
//                profile.abWorkoutDates.append(getDate())
//                profile.abWorkoutTimes.append(getDate(format: "hh:mm a"))
//                updateUserInfo(updatedField: "AbWorkoutDates", info: profile.abWorkoutDates, infoType: [String].self)
//                updateUserInfo(updatedField: "AbWorkoutTimes", info: profile.abWorkoutTimes, infoType: [String].self)
//            }
//        }
//    }
//
//    
//
//    Spacer()
//}
