//
//  SettingsItem.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct SettingsItem: View {
    @Environment(\.colorScheme) var colorScheme
    var leftText: String
    var rightText: String
    var colorOverride: Color?
    
    var body: some View {
        let darkColor = colorOverride ?? (colorScheme == .light ? Color.black : .white)
        let lightColor = colorScheme == .light ? Color.white : .black
        
        VStack(spacing: 0) {
            ZStack {
                lightColor
                HStack {
                    Text(self.leftText)
                    
                    Spacer()
                    
                    Text(self.rightText)
                }
                .foregroundColor(darkColor)
                .font(.system(size: screenWidth * 0.04))
                .padding(.horizontal)
            }
            
            Rectangle()
                .fill(darkColor.opacity(0.1))
                .frame(height: 1)
        }
        .frame(width: screenWidth * 0.95, height: screenHeight * 0.07)
    }
}

struct SettingsItem_Previews: PreviewProvider {
    static var previews: some View {
        SettingsItem(leftText: "Username", rightText: "Rohan Kumar")
    }
}
