//
//  SignUpView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var profile: ProfileManager
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var reEnteredPassword = ""
    @State private var maintenanceCalories = ""
    @State private var currentWeight = ""
    @State private var goalWeight = ""
    
    @State private var isLoading = false
    @State private var feedbackText = ""
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            defaultPurple.opacity(0.6).ignoresSafeArea()
            VStack(alignment: .center) {
                
                Image("taro-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.7)
                    .shadow(color: .white.opacity(0.3), radius: 20, x: 0, y: -20)
                    .padding(.bottom)
                
                
                Group {
                    AuthTextfield("Full Name", textVar: self.$username, imageName: "person.fill", isSecureField: false, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Email", textVar: self.$email, imageName: "envelope.fill", isSecureField: false, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Password", textVar: self.$password, imageName: "lock.fill", isSecureField: true, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Re-Enter Password", textVar: self.$reEnteredPassword, imageName: "lock.fill", isSecureField: true, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Calories Goal", textVar: self.$maintenanceCalories, imageName: "fork.knife", isSecureField: false, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Current Weight", textVar: self.$currentWeight, imageName: "scalemass.fill", isSecureField: false, paddingSize: 10, fontSize: screenWidth * 0.045)
                    AuthTextfield("Goal Weight", textVar: self.$goalWeight, imageName: "chart.xyaxis.line", isSecureField: false, paddingSize: 10, fontSize: screenWidth * 0.045)
                }
                .padding(.bottom)
                
                    
                
                VStack(spacing: 0) {
                    
                    // Create account button
                    Button { self.createNewAccount() } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(darkPurple)

                            Text("Create Account")
                                .font(.system(size: screenWidth * 0.045, weight: .semibold))
                                .foregroundColor(.white)

                        }
                        .shadow(color: darkPurple.opacity(0.3), radius: 15, x: 0, y: 5)
                        .frame(width: screenWidth * 0.5, height: screenHeight * 0.06)
                    }
                    
                    // Loading circle
                    ProgressView()
                        .tint(darkPurple)
                        .padding()
                        .opacity(self.isLoading ? 1 : 0)

                    Button("Already Have An Account?") {
                        withAnimation { authState.currentPage = 1 }
                    }
                    .font(.system(size: screenWidth * 0.03))
                    .padding(.bottom)
                    .foregroundColor(shadowColor)
                }
                
            }
        }
    }
    
    
    // Function called when Create Account Button is Pressed
    func createNewAccount() {
        // Does not authenticate user unless both passwords match
        if self.password != self.reEnteredPassword {
            self.feedbackText = "Passwords do not match"
            return
            
        }
        
        // Does not authenticate user unless maintenance calories is valid number
        if let cals = Int(self.maintenanceCalories), let goalWeight = Double(self.goalWeight), let currWeight = Double(self.currentWeight) {
        
            self.isLoading = true // Indicates that Firebase call is loading
            
            // Firebase call to authenticate new user
            FirebaseManager.shared.auth.createUser(withEmail: self.email, password: self.password) {
                result, error in
                if let err = error { // Error Message
                    self.feedbackText = convertErrorMessage(err as NSError)
                    self.isLoading = false
                    return
                }

                // Create Account was successful if it reached this line of code
                self.feedbackText = ""
                guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return } // Gets current User ID

                // TODO: Update Initial userData by adding more fields as more components are added
                let userInfo:Dictionary<String, Any> = [
                    "Username": self.username,
                    "UID": uid,
                    "ProfilePicURL": "",
                    "WeightHistory": [currWeight],
                    "WeightHistoryDates": [getDate()],
                    "CaloriesEatenHistory": [0],
                    "CaloriesEatenHistoryDates": [getDate()],
                    "MaintenanceCalories": cals,
                    "GoalWeight": goalWeight
                    ]
                // Stores userInfo into user's firestore file
                FirebaseManager.shared.firestore.collection("users").document(uid).setData(userInfo) { err in
                    if let err = err {
                        print(err)
                        return
                    }
                }

                profile.getUpdatedUserData() // Updates user Data
                profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()
                self.isLoading = false // Indicates that Firebase call has finished
            }
        
        }
        else {
            self.feedbackText = "Invalid entry"
            return
        }
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(ProfileManager())
            .environmentObject(AuthState())
    }
}
