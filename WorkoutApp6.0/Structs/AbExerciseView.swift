//
//  AbExerciseView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/29/22.
//

import SwiftUI

struct AbExerciseView: View {
    @EnvironmentObject var coreManager: CoreWorkoutManager
    @Binding var currentDisplayedGif: Int?
    
    var body: some View {
        ZStack {
            if let i = self.currentDisplayedGif {
                Color.black.opacity(0.7).ignoresSafeArea()
                
                GifImage(coreManager.getWorkoutArray()[i])
                    .scaledToFill()
                    .frame(width: screenWidth * 0.9, height: screenWidth * 0.5, alignment: .top)
                    .clipped()
            }
            
        }
        .onTapGesture {
            withAnimation { currentDisplayedGif = nil }
        }
        
        
    }
}

struct AbExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}
