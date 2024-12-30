//
//  Header.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/9/22.
//

import SwiftUI

struct Header: View {
    @Environment(\.colorScheme) var colorScheme
    var headerText: String
    
    var body: some View {
        ZStack {
            defaultPurple.opacity(colorScheme == .light ? 0.5 : 0.6).ignoresSafeArea()

            Text(headerText)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
        }
        .frame(height: screenHeight * 0.05)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(headerText: "Header")
    }
}
