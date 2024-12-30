//
//  LoadingView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 9/6/22.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            defaultPurple.ignoresSafeArea()
            
            VStack(spacing: screenHeight * 0.05) {
                Image("taro-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.6)
                    .scaleEffect(self.isLoading ? 1 : 0)
            }
            
        }
        .opacity(self.isLoading ? 1 : 0)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation { self.isLoading = false }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
