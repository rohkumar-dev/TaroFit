//
//  DeleteAccount.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 12/9/22.
//

import SwiftUI

struct DeleteAccount: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var profile: ProfileManager
    @Binding var toggleSheet: Bool
    
    
    @State private var selectedSetting: Int?
    @State private var selectedInfoButton: Int?
    
    @State private var confirmationView = false
    
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black

        VStack(spacing: 0) {
            
            // Header
            ZStack {
                Header(headerText: "Delete Account")
                
                // X and check buttons
                HStack(spacing: screenWidth * 0.8) {
                    Button {
                        withAnimation { self.toggleSheet = false }
                    } label: {
                        Image(systemName: "xmark")
                    }
                        
                    Button {
                        if self.selectedSetting != nil {
                            self.confirmationView = true
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .opacity(selectedSetting != nil ? 1 : 0.4)
                            
                    }
                }
                .foregroundColor(.white)
            }
            
            
            VStack(spacing: 0) {
                let deleteOptions = ["Reset Weight Data", "Reset Calorie Data", "Reset Ab Workout Data", "Reset All Account Data", "Delete Account"]
                
                let deleteInfos = ["Resetting Weight Data will remove all the data you inputted via the Weight Graph. This can NOT be undone.", "Resetting Calorie Data will remove all the data you inputted via the Calorie Tracker. This can NOT be undone.", "Resetting Ab Work Data will remove all the data tracking the days you completed an Ab Workout. This can NOT be undone.", "Resetting All Account Data will remove all the data you inputted for your Weight Graph and Calorie Tracker. It will also remove all data tracking the days you completed an Ab Workout. This can NOT be undone.", "Deleting your account will remove all the data and hard work you have inputted into TaroFit as well as remove your credentials from our system. This can NOT be undone."]
                
            // Main entry field
                ForEach(0..<deleteOptions.count, id: \.self) { i in
                    ZStack {
                        (selectedSetting == i ? darkColor.opacity(0.1) : lightColor)
                        
                        VStack(spacing: 0) {
                            
                            HStack {
                                Text(deleteOptions[i])
                                    .font(.system(size: 15, weight: selectedSetting == i ? .semibold : .regular))
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        self.selectedInfoButton = self.selectedInfoButton == i ? nil : i
                                    }
                                    self.selectedSetting = i
                                } label: {
                                    Image(systemName: "info.circle")
                                }
                            }
                            .foregroundColor(i == 4 ? Color.red : darkColor)
                            .opacity(0.8)
                            .padding()
                        
                            // Info text
                            if self.selectedInfoButton == i {
                                Text(deleteInfos[i])
                                    .foregroundColor(darkColor)
                                    .opacity(0.6)
                                    .font(.system(size: 12))
                                    .padding()
                            }
                            
                        }

                    }
                    .frame(height: self.selectedInfoButton == i ? UIScreen.main.bounds.height * 0.2 : UIScreen.main.bounds.height * 0.07)
                    .onTapGesture {
                        self.selectedSetting = self.selectedSetting == i ? nil : i
                    }
                }
                .confirmationDialog("Are you sure you want to \(deleteOptions[self.selectedSetting ?? 0])?", isPresented: self.$confirmationView, titleVisibility: .visible) {
                    Button("Yes", role: .destructive) {
                        if self.selectedSetting == 0 || self.selectedSetting == 3 {
                            profile.weightHistory = []
                            profile.weightHistoryDates = []
                            updateUserInfo(updatedField: "WeightHistory", info: profile.weightHistory, infoType: [Double].self)
                            updateUserInfo(updatedField: "WeightHistoryDates", info: profile.weightHistoryDates, infoType: [String].self)

                        }
                        if self.selectedSetting == 1 || self.selectedSetting == 3 {
                            profile.caloriesEatenHistory = []
                            profile.caloriesEatenHistoryDates = []
                            updateUserInfo(updatedField: "CaloriesEatenHistory", info: profile.caloriesEatenHistory, infoType: [Int].self)
                            updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: profile.caloriesEatenHistoryDates, infoType: [String].self)
                        }
                        if self.selectedSetting == 2 || self.selectedSetting == 3 {
                            profile.abWorkoutDates = []
                            profile.abWorkoutTimes = []
                            updateUserInfo(updatedField: "AbWorkoutDates", info: profile.abWorkoutDates, infoType: [String].self)
                            updateUserInfo(updatedField: "AbWorkoutTimes", info: profile.abWorkoutTimes, infoType: [String].self)
                        }
                        if self.selectedSetting == 4 {
                            
                            let currUser = FirebaseManager.shared.auth.currentUser
                            FirebaseManager.shared.firestore.collection("users").document(currUser?.uid ?? "").delete() { err in
                                if let err = err {
                                    print(err)
                                } else {
                                    print("Successfully Deleted Firestore Data")
                                }
                            }
                            
                            currUser?.delete() { err in
                                if let err = err {
                                    print(err)
                                } else {
                                    print("Account Successfully Deleted")
                                }
                            }
                            
                            
                        }
                        
                        profile.isLoggedIn = false
                        self.toggleSheet = false
                        
                        
                        
                    }
                }
                
            }
            

            
            
            
            Spacer()
        }
        
    }
}

struct DeleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccount(toggleSheet: .constant(true))
            .environmentObject(ProfileManager())
    }
}
