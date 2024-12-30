//
//  AuthTextfield.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/13/22.
//

import SwiftUI

struct AuthTextfield: View {
    @Binding var textVar: String
    var isSecureField: Bool
    var defaultText: String
    var imageName: String
    var paddingSize: CGFloat
    var fontSize: CGFloat
    
    init(_ defaultText: String, textVar: Binding<String>, imageName: String, isSecureField: Bool = false, paddingSize: CGFloat = 5, fontSize: CGFloat = screenWidth * 0.045) {
        self.defaultText = defaultText
        self._textVar = textVar
        self.imageName = imageName
        self.isSecureField = isSecureField
        self.paddingSize = paddingSize
        self.fontSize = fontSize
    }
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            
            HStack(spacing: 0) {
                Image(systemName: self.imageName)
                    .font(.system(size: 0.9 * self.fontSize))
                    .opacity(0.5)
                    .padding(.leading)
                
                ZStack(alignment: .leading) {
                    Text(self.textVar == "" ? self.defaultText : "")
                        .opacity(0.5)
                    
                    if self.isSecureField {
                        SecureField("", text: self.$textVar)
                            .background(.clear)
                    } else {
                        TextField("", text: self.$textVar)
                            .background(.clear)
                    }
                    
                    
                }
                .font(.system(size: self.fontSize))

                .padding(.leading)

                
                Spacer()
            }
            .padding(.vertical, self.paddingSize)
            
//            Rectangle()
//                .fill(.black.opacity(0.4))
//                .frame(width: screenWidth * 0.8, height: 1)

            
            
        }
        .foregroundColor(.black)
        .frame(width: screenWidth * 0.8, height: screenHeight * 0.05)

    }
}

struct AuthTextfield_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(NavigationManager())
            .environmentObject(ProfileManager())
    }
}
