//
//  SmallAnimatedLoadingView.swift
//  SPEA
//
//  Created by Lee Jun Lei Adam on 7/8/24.
//

import SwiftUI

struct SmallAnimatedLoadingView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Image("SPEA")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
                .onAppear {
                    // Increase the duration for a longer animation cycle
                    let baseAnimation = Animation.easeInOut(duration: 1) // Duration of 4 seconds
                    let repeated = baseAnimation.repeatForever(autoreverses: true)
                    withAnimation(repeated) {
                        self.scale = 1.2
                    }
                }
        }
    }
}
