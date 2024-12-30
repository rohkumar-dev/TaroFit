//
//  ContentView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/24/22.
//

import SwiftUI


struct ContentView: View {
    @StateObject var navInfo = NavigationManager()
    @StateObject var profile = ProfileManager()
    
    var body: some View {
        // Main app view
        if profile.isLoggedIn {

            ZStack {
                // Tabview (allows user to scroll through views)
                TabView(selection: $navInfo.currentTab) {
                    defaultPurple.opacity(0.5).ignoresSafeArea()

                    HomeView().tag(0)
                    WeightTrackerView().tag(1)
                    CoreView().tag(3)
                    CalendarView().tag(4)
                    
                    defaultPurple.opacity(0.5).ignoresSafeArea()

                    
                }
                .tabViewStyle(.page)
                .ignoresSafeArea()
                .blur(radius: navInfo.displayPlusView ? 5 : 0)
                  
                SettingsView()
                
                PlusView()
                
                Footer()
                
                
            }
            .environmentObject(navInfo)
            .environmentObject(profile)
            // Meal entry field
            .fullScreenCover(isPresented: $navInfo.showMealEntrySheet) {
                CustomEntryField(.constant("Meal Entry"), entryText: .constant("Enter Calories"), entryLabel: .constant("cals"), toggleSheet: $navInfo.showMealEntrySheet) { mealEntryStr, date in
                    
                    if let mealEntry = Int(mealEntryStr) {

                        let dateStr = getDate(date)
                        if let i = profile.caloriesEatenHistoryDates.firstIndex(of: dateStr) {
                            // If date is found, adds calories to previous entry on that date
                            if i < profile.caloriesEatenHistory.count {
                                profile.caloriesEatenHistory[i] += mealEntry
                            } else {
                                // Adds array of 0's to fix corrupted data, then adds calories to entry
                                let arrayAdded = Array.init(repeating: 0, count: profile.caloriesEatenHistoryDates.count - profile.caloriesEatenHistory.count)
                                profile.caloriesEatenHistory.append(contentsOf: arrayAdded)
                                profile.caloriesEatenHistory[i] += mealEntry
                            }
                        } else {
                            // Else finds correct index of date and adds new data
                            for i in 0..<profile.caloriesEatenHistoryDates.count {
                                if let currDate = getDate(profile.caloriesEatenHistoryDates[i]) {
                                    if currDate > date {
                                        profile.caloriesEatenHistoryDates.insert(dateStr, at: i)
                                        // If index exists in array, then inserts in proper spot
                                        if i < profile.caloriesEatenHistory.count {
                                            profile.caloriesEatenHistory.insert(mealEntry, at: i)
                                        } else {
                                            // Adds array of 0's to fix corrupted data, then adds calories to entry
                                            let arrayAdded = Array.init(repeating: 0, count: profile.caloriesEatenHistoryDates.count - profile.caloriesEatenHistory.count)
                                            profile.caloriesEatenHistory.append(contentsOf: arrayAdded)
                                            profile.caloriesEatenHistory[i] += mealEntry
                                        }
                                        break
                                    }
                                }
                            }
                        }
                    
                        // Updates info on firebase
                        updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: profile.caloriesEatenHistoryDates, infoType: [String].self)
                        
                        updateUserInfo(updatedField: "CaloriesEatenHistory", info: profile.caloriesEatenHistory, infoType: [Int].self)

                    }
                }
            }
            // Weight entry field
            .fullScreenCover(isPresented: $navInfo.showWeightEntrySheet) {
                CustomEntryField(.constant("Weight Entry"), entryText: .constant("Enter Weight"), entryLabel: .constant("lbs"), toggleSheet: $navInfo.showWeightEntrySheet) { weightEntryStr, date in
                    if let weightEntry = Double(weightEntryStr) {
                                                
                        let dateStr = getDate(date)
                        
                        if profile.weightHistory.count == 0 {
                            profile.weightHistory.append(weightEntry)
                            profile.weightHistoryDates.append(dateStr)
                        } else {
                        
                            if let i = profile.weightHistoryDates.firstIndex(of: dateStr) {
                                // If date is found, replaces previous entry on that date
                                if i < profile.weightHistory.count {
                                    profile.weightHistory[i] += weightEntry
                                } else {
                                    // Adds array of 0's to fix corrupted data, then adds calories to entry
                                    let arrayAdded = Array.init(repeating: 0.0, count: profile.weightHistoryDates.count - profile.weightHistory.count)
                                    profile.weightHistory.append(contentsOf: arrayAdded)
                                    profile.weightHistory[i] = weightEntry
                                }
                            } else {
                                // Else finds correct index of date and adds new data
                                for i in 0..<profile.weightHistoryDates.count {
                                    if let currDate = getDate(profile.weightHistoryDates[i], format: "MM/dd/yyyy") {
                                        if currDate > date {
                                            profile.weightHistoryDates.insert(dateStr, at: i)
                                            if i < profile.weightHistory.count {
                                                profile.weightHistory.insert(weightEntry, at: i)
                                            } else {
                                                // Adds array of 0's to fix corrupted data, then replaces entry with weightEntry
                                                let arrayAdded = Array.init(repeating: 0.0, count: profile.weightHistoryDates.count - profile.weightHistory.count)
                                                profile.weightHistory.append(contentsOf: arrayAdded)
                                                profile.weightHistory[i] = weightEntry
                                            }
                                            break
                                        } else if i >= profile.weightHistoryDates.count-1 {
                                            profile.weightHistoryDates.append(dateStr)
                                            profile.weightHistory.append(weightEntry)
                                        }
                                    }
                                }
                            }
                            
                        }
                                                
                        // Updates firebase info
                        updateUserInfo(updatedField: "WeightHistory", info: profile.weightHistory, infoType: [Double].self)
                        
                        updateUserInfo(updatedField: "WeightHistoryDates", info: profile.weightHistoryDates, infoType: [String].self)
                    }
                }
            }
            // Stops phone from falling asleep when user does not touch screen
            .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
            
        }
        else {
            AuthenticationView()
                .environmentObject(profile)
                .environmentObject(navInfo)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
