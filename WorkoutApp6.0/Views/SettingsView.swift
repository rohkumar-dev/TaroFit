//
//  SettingsView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/1/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var navInfo: NavigationManager
    @State private var showImagePicker = false
    @State private var profilePic: UIImage?
    
    // Sheet info
    @State private var titleText = ""
    @State private var entryText = ""
    @State private var entryLabel = ""
    @State private var sheetFunc: (String, Date) -> () = { (str, date) in
        print(str)
    }
    @State private var deleteAccountSheet = false
    @State private var showEntrySheet = false
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        ZStack {
            defaultPurple.opacity(0.5).ignoresSafeArea()

            VStack {
                
                // Header
                ZStack {
                    Text("Edit Profile")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(lightColor)
                        )
                        .shadow(color: footerPurple.opacity(0.3), radius: 10, x: 0, y: 10)
                    
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                navInfo.showSettingsView = false
                                navInfo.currentTab = 0
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: screenWidth * 0.05, weight: .semibold))
                                .padding(.trailing)
                        }
                    }
                }
                .padding(.top, screenHeight * 0.05)
                
                
                // Main info view
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(lightColor)
                    
                    VStack {
                        Button {
                            self.showImagePicker = true
                        } label: {
                            VStack(spacing: 6) {
                                ProfilePic(radius: screenWidth * 0.45)
                                
                                Text("Change Profile Picture")
                                    .font(.system(size: 10))
                            }
                        }
                        .padding()
                        
                        // Username - Calories Goal - Weight Goal - Delete Account
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(darkColor.opacity(0.1))
                                .frame(height: 1)
                            
                            let buttonsText = [
                                ("Username", profile.username),
                                ("Calories Goal", "\(profile.maintenanceCalories) cals"),
                                ("Weight Goal", "\(profile.goalWeight) lbs")
                            ]
                            let sheetsInfo = [
                                ("Update Username", "Username", "", updateUsername),
                                ("Calories Goal", "Calories Goal", "cals", updateMaintCalories),
                                ("Update Goal Weight", "Goal Weight", "lbs", updateGoalWeight)
                            ]
                            ForEach(0..<sheetsInfo.count, id: \.self) { i in
                                Button {
                                    self.titleText = sheetsInfo[i].0
                                    self.entryText = sheetsInfo[i].1
                                    self.entryLabel = sheetsInfo[i].2
                                    self.sheetFunc = sheetsInfo[i].3
                                    self.showEntrySheet = true
                                } label: {
                                    SettingsItem(leftText: buttonsText[i].0, rightText: buttonsText[i].1)
                                        .foregroundColor(darkColor)
                                }
                            }
                            
                            Button {
                                self.deleteAccountSheet = true
                            } label: {
                                SettingsItem(leftText: "Clear Account Data", rightText: "", colorOverride: .red)
                            }
                            
                        }
                        
                        Spacer()
                        
                        Button("Log Out") {
                            profile.isLoggedIn = false
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(darkPurple.opacity(colorScheme == .light ? 1 : 0.6))
                        .cornerRadius(10)
                        .shadow(color: darkPurple.opacity(0.4), radius: 30, x: 0, y: 5)

                        Spacer()
                    }
                    
                }
                .frame(width: screenWidth * 0.95, height: screenHeight * 0.77)
                
                Spacer()
            }
        }
        .foregroundColor(darkColor)
        .frame(width: screenWidth, height: screenHeight)
        .opacity(navInfo.showSettingsView ? 1 : 0)
        // Image picker
        .fullScreenCover(
            isPresented: self.$showImagePicker,
            onDismiss: {
                storeProfilePic(self.profilePic) {
                    profile.getUpdatedUserData()
                }
            self.showImagePicker = false
            }
        ) {
            ImagePicker(image: self.$profilePic)
        }
        //Generic Entry Sheet
        .fullScreenCover(isPresented: self.$showEntrySheet) {
            CustomEntryField(self.$titleText, showDatePicker: false, entryText: self.$entryText, entryLabel: self.$entryLabel, toggleSheet: self.$showEntrySheet) { str, date in
                self.sheetFunc(str, date)
            }
        }
        .fullScreenCover(isPresented: self.$deleteAccountSheet) {
            DeleteAccount(toggleSheet: self.$deleteAccountSheet)
                .environmentObject(profile)
        }
        
        
    }
    
    func getFirstDayOnApp() -> String {
        if profile.caloriesEatenHistoryDates.count > 0 {
            let firstDate = getDate(profile.caloriesEatenHistoryDates[0]) ?? Date()
            return getDate(firstDate, format: "MMM dd, yyyy")
        }
        return ""
    }
    
    func updateMaintCalories(_ maintCaloriesStr: String, date: Date) {
        if let maintCalories = Int(maintCaloriesStr) {
            profile.maintenanceCalories = maintCalories
            updateUserInfo(updatedField: "MaintenanceCalories", info: maintCalories, infoType: Int.self)
        }
    }
    
    func updateUsername(_ username: String, date: Date) {
        profile.username = username
        updateUserInfo(updatedField: "Username", info: username, infoType: String.self)
    }
    
    func updateGoalWeight(_ goalWeightStr: String, date: Date) {
        if let goalWeight = Double(goalWeightStr) {
            profile.goalWeight = goalWeight
            updateUserInfo(updatedField: "GoalWeight", info: goalWeight, infoType: Double.self)
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ProfileManager())
            .environmentObject(NavigationManager())
            .preferredColorScheme(.light)
    }
}
