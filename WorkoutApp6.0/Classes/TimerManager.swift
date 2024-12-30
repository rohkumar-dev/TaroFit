//
//  TimerManager.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/28/22.
//

import Foundation
import SwiftUI

enum TimerMode {
    case initial
    case running
    case paused
}

enum WorkoutState {
    case working
    case resting
}

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var volumeEnabled: Bool = true
    
    @Published var setLength: Int = 0
    @Published var restLength: Int = 0
    
    @Published var totalSecondsLeft: Int = 0 // Seconds left in entire workout
    @Published var secondsLeftInSet: Int = 0 // Seconds left in current exercise or rest
    @Published var currentExercise: Int = 0
    @Published var currentExerciseState: WorkoutState = .working
    
    @Published var workoutInProgress = false
    
    var timer = Timer()
    
    // Pre-workout functions
    
    func setDifficulty(workoutDifficulty: CGFloat) {
        // Updates setlength and restlength vars based on workout difficulty inputted
        switch workoutDifficulty {
        case 0:
            self.setLength = 30
            self.restLength = 20
        case 1:
            self.setLength = 45
            self.restLength = 20
        case 2:
            self.setLength = 50
            self.restLength = 20
        case 3:
            self.setLength = 60
            self.restLength = 15
        case 4:
            self.setLength = 65
            self.restLength = 10
        default:
            self.setLength = 0
            self.restLength = 0
        }
        
        // Updates total seconds and seconds left variables
        self.totalSecondsLeft = 7 * (self.setLength + self.restLength) - self.restLength
        self.secondsLeftInSet = self.setLength
    }
    
    
    
    // Mid-workout functions
    
    func pause() {
        self.timer.invalidate()
        self.timerMode = .paused
    }
    
    func reset() {
        self.timer.invalidate() // Ends timer
        
        // Resets all state variables
        self.timerMode = .initial
        self.totalSecondsLeft = 7 * (self.setLength + self.restLength) - self.restLength
        self.secondsLeftInSet = self.setLength
        self.currentExercise = 0
        self.currentExerciseState = .working
    }
    
    func increment() {
        self.totalSecondsLeft -= self.currentExerciseState == .working ? self.secondsLeftInSet + self.restLength : self.secondsLeftInSet
        self.currentExercise += 1
        self.secondsLeftInSet = self.setLength
        self.currentExerciseState = .working
    }
    
    func decrement() {
        self.totalSecondsLeft += self.currentExerciseState == .working ? self.secondsLeftInSet + self.restLength : self.secondsLeftInSet
        self.currentExercise -= 1
        self.secondsLeftInSet = self.setLength
        self.currentExerciseState = .working
    }
    
    
    
    
    func start() {
        self.timerMode = .running
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.totalSecondsLeft <= 0 {
                // Finishes workout, resets all timer info
                self.timerMode = .initial
                self.currentExercise = 1
                self.reset()
                if self.volumeEnabled { SoundManager.shared.playSound("beep") }
                
                withAnimation { self.workoutInProgress = false }
            } else if self.secondsLeftInSet <= 0 { // Set has finished
                
                if self.volumeEnabled { SoundManager.shared.playSound("beep") }
                
                if self.currentExerciseState == .working {
                    // Initialize rest break
                    self.secondsLeftInSet = self.restLength // Sets current set time to rest time
                    self.currentExerciseState = .resting
                } else {
                    // Initialize working set
                    self.currentExercise += 1 // Moves to next exercise
                    self.secondsLeftInSet = self.setLength // Sets current set time to set time
                    self.currentExerciseState = .working
                }
            } else {
                // Advances timer if no edge cases are reached
                self.secondsLeftInSet -= 1
                self.totalSecondsLeft -= 1
            }
        })
    }
    
    
    
}


