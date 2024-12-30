//
//  LoginScreen.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var profile: ProfileManager
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var feedbackText = ""
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            defaultPurple.opacity(0.6).ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                
                // Logo
                Image("taro-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.7)
                    .shadow(color: .white.opacity(0.3), radius: 20, x: 0, y: -20)
                
                Spacer()
                
                // Textfields
                Group {
                    AuthTextfield("Email", textVar: self.$email, imageName: "person.fill", isSecureField: false, paddingSize: 15, fontSize: screenWidth * 0.055)
                    AuthTextfield("Password", textVar: self.$password, imageName: "lock.fill", isSecureField: true, paddingSize: 15, fontSize: screenWidth * 0.055)
                }
                .padding(.bottom)
                
                
                Spacer()
                    
                VStack(spacing: 0) {
                    // Log in button
                    Button { self.logInExistingAccount() } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(darkPurple)

                            Text("Log In")
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

                    Button("Don't Have An Account?") {
                        withAnimation { authState.currentPage = 2 }
                    }
                    .font(.system(size: screenWidth * 0.03))
                    .padding(.bottom)
                    .foregroundColor(shadowColor)
                    
                    Text(self.feedbackText)
                        .foregroundColor(.red)
                        .font(.system(size: screenWidth * 0.03))
                }
                    
                Spacer()
            }
        }
    }
    
    
    // Function to login user
    func logInExistingAccount() {
        self.isLoading = true // Indicates that Firebase call is loading

        // Firebase call to authenticate existing user
        FirebaseManager.shared.auth.signIn(withEmail: self.email, password: self.password) {
            result, error in
            if let err = error { // Error Message
                self.feedbackText = convertErrorMessage(err as NSError)
                self.isLoading = false
                return
            }

            // Login was successful if it reached this line of code
            self.feedbackText = ""

            profile.getUpdatedUserData() // Updates User Data
            profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()

            self.isLoading = false // Indicates that Firebase call has finished

        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.light)
            .environmentObject(ProfileManager())
            
    }
}

//ZStack {
//
//    Color.init(white: 0.98).ignoresSafeArea()
//    // Top half of screen
//    VStack {
//
//        ZStack {
//            // Background purple rectangle
//            RoundedRectangle(cornerRadius: 10)
//                .fill(darkPurple)
//                .ignoresSafeArea()
//                .offset(y: -30)
//
//            // Info inside rectangle
//            VStack(alignment: .leading) {
//                // Right arrow button
//                HStack {
//                    Spacer()
//                    Button {
//                        withAnimation { authState.currentPage = 2 }
//                    } label: {
//                        Image(systemName: "arrow.right")
//                            .foregroundColor(.white)
//                            .font(.system(size: screenWidth * 0.05, weight: .semibold))
//                    }
//                    .padding()
//                }
//
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Log In")
//                        .font(.system(size: screenWidth * 0.07, weight: .bold))
//
//                    Text("Continue your fitness journey\nand sculpt your perfect body.")
//                        .font(.system(size: screenWidth * 0.03))
//                }
//                .foregroundColor(.white)
//                .padding(.leading)
//
//                Spacer()
//
//            }
//        }
//        .frame(height: screenHeight * 0.25 + 30)
//
//
//        Spacer()
//    }
//
//    // Email/password rectangle
//    ZStack {
//        RoundedRectangle(cornerRadius: 35)
//            .fill(.white)
//            .shadow(color: footerPurple.opacity(0.2), radius: 30, x: 10, y: 30)
//
//        VStack {
//
//            Spacer()
//
//            // Textfields
//            AuthTextfield("Email", textVar: self.$email)
//            AuthTextfield("Password", textVar: self.$password, isSecureField: false)
//
//
//            // Error text
//            Text(self.feedbackText)
//                .foregroundColor(.red.opacity(0.8))
//                .font(.system(size: screenWidth * 0.03))
//
//            Spacer()
//
//            // Log in button
//            Button {
//                withAnimation { self.logInExistingAccount() }
//            } label: {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 8)
//                        .fill(darkPurple)
//
//                    Text("Log in")
//                        .font(.system(size: screenWidth * 0.04, weight: .semibold))
//                        .foregroundColor(.white)
//
//                }
//                .shadow(color: darkPurple.opacity(0.3), radius: 15, x: 0, y: 5)
//                .frame(width: screenWidth * 0.7, height: screenHeight * 0.07)
//            }
//
//            // Loading circle
//            ProgressView()
//                .tint(darkPurple)
//                .padding()
//                .opacity(self.isLoading ? 1 : 0)
//
//            Spacer()
//
//            Button("Don't Have An Account?") {
//                withAnimation { authState.currentPage = 2 }
//            }
//            .font(.system(size: screenWidth * 0.03))
//            .padding(.bottom)
//
//
//
//        }
//        .frame(width: screenWidth * 0.85, height: screenHeight * 0.5)
//
//    }
//    .frame(width: screenWidth * 0.9, height: screenHeight * 0.55)
//
//
//}













// TODO: GOOGLE SIGN IN
// "Or connect using" line
//                    HStack {
//                        Rectangle()
//                            .fill(.black.opacity(0.4))
//                            .frame(width: screenWidth * 0.17, height: 1)
//
//                        Spacer()
//
//                        Text("Or connect using")
//                            .font(.system(size: 10, weight: .light))
//
//                        Spacer()
//
//                        Rectangle()
//                            .fill(.black.opacity(0.4))
//                            .frame(width: screenWidth * 0.17, height: 1)
//
//                    }
//                    .frame(width: screenWidth * 0.6, height: screenHeight * 0.1)
