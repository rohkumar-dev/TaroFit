//
//  CoreButton.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct CoreButton: View {
    @Environment(\.colorScheme) var colorScheme
    var iconName: String
    var buttonFunc: ()->()
    
    var body: some View {
        Button {
            self.buttonFunc()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(defaultPurple.opacity(colorScheme == .light ? 1 : 0.6))
                    .shadow(color: footerPurple.opacity(0.5), radius: 15, x: 0, y: 0)
                
                Image(systemName: self.iconName)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular))
            }
            .frame(width: screenWidth * 0.25, height: screenHeight * 0.06)
        }
    }
}

struct CoreButton_Previews: PreviewProvider {
    static var previews: some View {
        CoreButton(iconName: "shuffle") {
            print("Hi")
        }
        .preferredColorScheme(.dark)
    }
}
