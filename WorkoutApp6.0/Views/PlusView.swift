//
//  PlusView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/31/22.
//

import SwiftUI

struct PlusView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navInfo: NavigationManager
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        ZStack {
            Color.black.opacity(navInfo.displayPlusView ? 0.4 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation { navInfo.displayPlusView = false }
                }
            VStack {
                Spacer()
                HStack(spacing: screenWidth * 0.1) {
                    // Meal entry sheet button
                    Button {
                        withAnimation {
                            navInfo.showMealEntrySheet = true
                            navInfo.displayPlusView = false
                        }
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(lightColor)
                                .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                            
                            Image("salad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                        }
                    }
                    .shadow(color: darkColor.opacity(0.2), radius: 15, x: 0, y: 0)
                    .offset(x: navInfo.displayPlusView ? 0 : screenWidth * 0.1)
                    
                    
                    // Meal entry sheet button
                    Button {
                        withAnimation {
                            navInfo.showWeightEntrySheet = true
                            navInfo.displayPlusView = false
                        }
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(lightColor)
                                .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                            
                            Image("weightscale")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                        }
                    }
                    .shadow(color: darkColor.opacity(0.2), radius: 15, x: 0, y: 0)
                    .offset(x: navInfo.displayPlusView ? 0 : -screenWidth * 0.1)

   
                    
                }
                .offset(y: navInfo.displayPlusView ? -screenHeight * 0.15 : 0)
                
            }
        }
        .frame(width: screenWidth, height: screenHeight)
    }
}

struct PlusView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
