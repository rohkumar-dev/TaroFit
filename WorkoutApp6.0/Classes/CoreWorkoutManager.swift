//
//  CoreExercises.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import Foundation
import SwiftUI

let lowerAbExercises = ["Flutter Kicks", "Jack Knives", "Leg Raises", "Reverse Crunch", "Seated Leg Circles", "Seated Leg Raises", "V Ups", "X Crunch"]
let lowerAbRotationExercises = ["Around The World", "Bent Knee Windshield Wipers", "Figure 8s", "Russian Twists", "Scissors", "Seated Leg Circles", "Windshield Wipers"]
let midAbExercises = ["Cross Knee Mountain Climbers", "Jack Knives", "Jump Tucks", "Seated Leg Raises", "Sprinter Planks", "Sprinter Tuck Planks", "Suitcases", "Tuck Planks"]
let midAbRotationExercises = ["Accordian Crunch", "Around The World", "Cross Knee Mountain Climbers", "Oblique Crunch", "Russian Twists", "Side Plank Raises", "Starfish Crunch", "Thread The Needle"]
let upperAbExercises = ["3-Sec Crunch Holds", "90-90 Crunch", "Crunches", "Hands Up Crunch", "Toe Touches"]
let upperAbRotationExercises = ["Ab Circles", "Accordian Crunch", "Cross Body Crunch", "Crunch and Twists", "Starfish Crunch"]
let accessoryExercises = ["3-Sec Crunch Holds", "Around The World", "Jump Tucks", "Sprinter Planks", "Supermans"]


let convertWorkoutDifficulty = [0: "Novice", 1: "Beginner", 2: "Intermediate", 3: "Advanced", 4: "Elite"]

class CoreWorkoutManager: ObservableObject {
    // Workout info variables
    @Published var lowerAbExercise = lowerAbExercises.randomElement()!
    @Published var lowerAbRotationExercise = lowerAbRotationExercises.randomElement()!
    @Published var midAbExercise = midAbExercises.randomElement()!
    @Published var midAbRotationExercise = midAbRotationExercises.randomElement()!
    @Published var upperAbExercise = upperAbExercises.randomElement()!
    @Published var upperAbRotationExercise = upperAbRotationExercises.randomElement()!
    @Published var accessoryExercise = accessoryExercises.randomElement()!
    
    // Preference variables
    @Published var workoutDifficulty: CGFloat = 0
    
    /// Reshuffles workout
    func shuffleWorkout() {
        self.lowerAbExercise = lowerAbExercises.randomElement()!
        self.lowerAbRotationExercise = lowerAbRotationExercises.randomElement()!
        self.midAbExercise = midAbExercises.randomElement()!
        self.midAbRotationExercise = midAbRotationExercises.randomElement()!
        self.upperAbExercise = upperAbExercises.randomElement()!
        self.upperAbRotationExercise = upperAbRotationExercises.randomElement()!
        self.accessoryExercise = accessoryExercises.randomElement()!
    }
    
    /// Returns array of strings holding each exercise in order
    func getWorkoutArray() -> [String] {
        return [self.lowerAbExercise, self.lowerAbRotationExercise, self.midAbExercise, self.midAbRotationExercise, self.upperAbExercise, self.upperAbRotationExercise, self.accessoryExercise]
    }
}
