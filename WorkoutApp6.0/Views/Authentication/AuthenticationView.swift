//
//  AuthenticationView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

class AuthState: ObservableObject {
    @Published var currentPage = 0
}

struct AuthenticationView: View {
    @StateObject var authState = AuthState()
    @EnvironmentObject var navInfo: NavigationManager
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            defaultPurple.opacity(0.6).ignoresSafeArea()
            
            
            TabView(selection: $authState.currentPage) {
                LoginView().tag(1)
                //AuthHome().tag(0)
                SignUpView().tag(2)
            }
            .tabViewStyle(.page)
            .ignoresSafeArea()
            .environmentObject(authState)
            .environmentObject(profile)
            .onDisappear {
                navInfo.currentTab = 0
                navInfo.showSettingsView = false
                navInfo.displayPlusView = false
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ProfileManager())
            .environmentObject(NavigationManager())
            .previewDevice("iPhone 13 mini")
    }
}
