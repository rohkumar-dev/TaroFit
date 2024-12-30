//
//  HomeButtons.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct HomeButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var iconName: String // Name of icon
    var buttonText: String // Label on bottom
    var buttonFunc: ()->() // Button function
    var isCompleted: Bool

    init(_ iconName: String, buttonText: String, isCompleted: Bool, buttonFunc: @escaping ()->()) {
        self.iconName = iconName
        self.buttonText = buttonText
        self.isCompleted = isCompleted
        self.buttonFunc = buttonFunc
    }
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        //let lightColor = colorScheme == .light ? Color.white : .black
        
        Button {
            withAnimation {
                self.buttonFunc()
            }
        } label: {
            // Displays white circle and icon
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(darkColor.opacity(0.07))
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.init(white: colorScheme == .light ? 0.985 : 0.15))
                    .frame(width: screenWidth * 0.25 - 1, height: screenWidth * 0.3 - 1)
                
                VStack(spacing: 5) {
                    
                    Image(self.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.16, height: screenWidth * 0.16, alignment: .bottom)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text(self.buttonText)
                        .foregroundColor(darkColor)
                        .font(.system(size: 9, weight: .bold))
                    
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 15))
                        .foregroundColor(.green.opacity(0.8))
                        .padding(.bottom, 5)
                        .opacity(self.isCompleted ? 1 : 0)
                }
            }
            .frame(width: screenWidth * 0.25, height: screenWidth * 0.3)
        }
    }
}

struct HomeButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton("salad", buttonText: "Track a Meal", isCompleted: true) { }
            .preferredColorScheme(.dark)
    }
}
