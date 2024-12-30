//
//  ProfileManager.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/24/22.
//

import Foundation

class ProfileManager: ObservableObject {
    // Profile Info
    @Published var isLoggedIn: Bool = false
    @Published var username: String = ""
    @Published var profilePicURL: String = ""
    
    // Nutrition / Weight Info
    @Published var maintenanceCalories: Int = 2000
    @Published var caloriesEatenHistory: [Int] = []
    @Published var caloriesEatenHistoryDates: [String] = []
    @Published var weightHistory: [Double] = []
    @Published var weightHistoryDates: [String] = []
    @Published var goalWeight: Double = 0
    
    // Ab Info
    @Published var abWorkoutDates: [String] = []
    @Published var abWorkoutTimes: [String] = []
    
    
    init() {
        // Initializes isLoggedIn
        if FirebaseManager.shared.auth.currentUser?.uid != "" {
            getUpdatedUserData()
        }
        else { isLoggedIn = false }
    }

    
    func getUpdatedUserData() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                // Profile
                self.profilePicURL = data["ProfilePicURL"] as? String ?? ""
                self.username = data["Username"] as? String ?? ""
                
                
                // Nutrition
                self.maintenanceCalories = data["MaintenanceCalories"] as? Int ?? 2000
                self.goalWeight = data["GoalWeight"] as? Double ?? 0
                self.weightHistory = data["WeightHistory"] as? [Double] ?? []
                self.weightHistoryDates = data["WeightHistoryDates"] as? [String] ?? []
                
                // Calorie History
                if let currCaloriesHistory = data["CaloriesEatenHistory"] as? [Int] {
                    // Assigns to current data if not empty
                    self.caloriesEatenHistory = currCaloriesHistory
                } else {
                    // Initializes caloriesEatenHistoryDates if empty
                    self.caloriesEatenHistory.append(0)
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [Int].self)
                }
                
                // Calorie History Dates
                if let currCaloriesHistoryDates = data["CaloriesEatenHistoryDates"] as? [String] {
                    // Assigns to current data if not empty
                    self.caloriesEatenHistoryDates = currCaloriesHistoryDates
                } else {
                    // Initializes caloriesEatenHistoryDates if empty
                    self.caloriesEatenHistoryDates.append(getDate())
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [String].self)
                }
                
                // Starts new day for calories if not already done
                if self.caloriesEatenHistoryDates.last ?? "" != getDate() {
                    // If new day, appends 0 to caloriesEatenHistory and current date to caloriesEatenHistoryDates
                    self.caloriesEatenHistory.append(0)
                    self.caloriesEatenHistoryDates.append(getDate())
                    // Updates variables in Firebase
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [String].self)
                    updateUserInfo(updatedField: "CaloriesEatenHistory", info: self.caloriesEatenHistory, infoType: [Int].self)
                }
                
                self.abWorkoutDates = data["AbWorkoutDates"] as? [String] ?? []
                self.abWorkoutTimes = data["AbWorkoutTimes"] as? [String] ?? []
                
                // Tells app that user is logged in
                self.isLoggedIn = true
                
                
            }
    }
}
