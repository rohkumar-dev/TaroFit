//
//  NavigationManager.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import Foundation

class NavigationManager: ObservableObject {
    @Published var showWeightEntrySheet = false
    @Published var showMealEntrySheet = false
    @Published var currentTab = 0
    @Published var displayPlusView = false
    @Published var showSettingsView = false
}
