//
//  OldHomeView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/31/22.
//

import Foundation
//struct HomeView: View {
//    @EnvironmentObject var navInfo: NavigationManager
//    @EnvironmentObject var profile: ProfileManager
//    @State private var greetingMessage = getGreeting()
//
//
//    @State private var showImagePicker = false
//    @State private var profilePic: UIImage?
//
//    var body: some View {
//        ZStack {
//            // Background color
//            defaultPurple.ignoresSafeArea()
//
//            VStack {
//
//                // App title text
//                ZStack {
//                    // Title text
//                    Text("App Name")
//                        .font(.system(size: screenWidth / 17, weight: .semibold))
//                        .foregroundColor(.white)
//
//                }
//
//                // Profile picture
//                ZStack {
//                    // Draws white circle border outside picture
//                    Circle()
//                        .strokeBorder(.white.opacity(0.7), lineWidth: 2)
//                        .frame(width: screenWidth * 0.35, height: screenWidth * 0.35)
//                        .foregroundColor(Color.clear)
//
//                    // Draws profile pic if available else default image
//                    if profile.profilePicURL == "" {
//                        // Draws default picture if no profile pic entered
//                        Image(systemName: "person.crop.circle")
//                            .font(.system(size: screenWidth * 0.3, weight: .ultraLight))
//                            .background(.clear)
//                            .foregroundColor(.black.opacity(0.7))
//                    } else {
//                    // Shows Profile pic if available
//                        WebImage(url: URL(string: profile.profilePicURL))
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3, alignment: .center)
//                            .cornerRadius(120)
//
//                    }
//                }
//                .onTapGesture { self.showImagePicker = true }
//
//                // Display greeting + username
//                VStack {
//
//                    // Greeting text
//                    Text(self.greetingMessage)
//                        .font(.system(size: screenWidth / 26, weight: .medium))
//                        .foregroundColor(.white)
//
//                    // Username text
//                    Text(profile.username.uppercased())
//                        .font(.system(size: screenWidth / 9, weight: .bold))
//                }
//
//                // Summary card TODO: MAKE BETTER LOOKING
//                ZStack {
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(.white)
//                        .shadow(color: shadowColor, radius: 50, x: 0, y: 15)
//
//                    VStack(spacing: screenHeight * 0.01) {
//
//                        // "Today" text
//                        HStack {
//                            Text("Today's Goals")
//                                .foregroundColor(.black.opacity(0.8))
//                                .font(.system(size: 23, weight: .bold))
//
//                            Spacer()
//                        }
//                        .padding(.leading, screenWidth * 0.07)
//                        .padding(.top, screenWidth * 0.05)
//
//                        // Line
//                        Rectangle()
//                            .fill(.black.opacity(0.7))
//                            .frame(width: screenWidth * 0.6, height: 1)
//                            .padding(.bottom)
//
//
//                        // To do items
//                        VStack(spacing: 0) {
//                            let todoItems = ["Enter Weight", "Train Your Core", "Track meal"]
//
//                            ForEach(0..<todoItems.count, id: \.self) { i in
//                                HStack(alignment: .top) {
//                                    // Circle and line for each item (line is not drawn for bottom item)
//                                    VStack(spacing: 0) {
//                                        Circle()
//                                            .stroke(defaultPurple, lineWidth: 3)
//                                            .frame(width: screenWidth * 0.05)
//                                            .padding(.horizontal)
//
//                                        Rectangle()
//                                            .fill(defaultPurple)
//                                            .frame(width: 1, height: screenHeight * 0.07)
//                                            .opacity(i == todoItems.count-1 ? 0 : 1)
//
//                                    }
//
//                                    Text(todoItems[i])
//                                        .font(.system(size: 20, weight: .light))
//
//                                    Spacer()
//
//                                }
//                                .frame(width: screenWidth * 0.6, height: screenHeight * 0.1)
//                            }
//                        }
//
//
//                        Spacer()
//                    }
//
//                }
//                .frame(width: screenWidth * 0.7, height: screenHeight * 0.4)
//
//
//                // Quick access buttons TODO: MIGHT REMOVE
//                HStack(spacing: screenWidth * 0.1) {
//                    let buttons: [(String, Binding<Bool>)] = [
//                        ("fork.knife", $navInfo.showMealEntrySheet),
//                        ("scalemass.fill", $navInfo.showWeightEntrySheet)
//                    ]
//
//                    ForEach(0..<buttons.count, id: \.self) { i in
//                        HomeButton(buttons[i].0, toggleSheet: buttons[i].1)
//                    }
//                }
//                .padding(.top)
//
//
//
//                Spacer()
//            }
//            .fullScreenCover(
//                isPresented: self.$showImagePicker,
//                onDismiss: {
//                    storeProfilePic(self.profilePic) {
//                        profile.getUpdatedUserData()
//                    }
//                    self.showImagePicker = false
//
//                }) {
//                ImagePicker(image: self.$profilePic)
//            }
//
//
//        }
//    }
//}
