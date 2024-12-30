//
//  ProfilePic.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/1/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
struct ProfilePic: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var profile: ProfileManager
    var radius: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(colorScheme == .light ? 0.7 : 0.4), lineWidth: 1)
                .frame(width: 1.1 * self.radius, height: 1.1 * self.radius)
            
            
            if profile.profilePicURL == "" {
                // Draws default picture if no profile pic entered
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 0.9 * self.radius, weight: .ultraLight))
                    .background(.clear)
                    .foregroundColor(Color.white.opacity(colorScheme == .light ? 0.7 : 0.4))
            } else {
                // Shows Profile pic if available
                WebImage(url: URL(string: profile.profilePicURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 0.9 * self.radius, height: 0.9 * self.radius, alignment: .center)
                    .cornerRadius(120)
                
            }
        }
    }
}
