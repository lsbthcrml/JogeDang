//
//  SplashScreenAnimation.swift
//  JogeDang
//
//  Created by Elisabeth Carmela on 29/04/24.
//

import Foundation
import SwiftUI

struct ImageChanger: View {
    @State private var currentImageIndex = 0
    
    var images: [Image]

    var body: some View {
        images[currentImageIndex]
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .transition(.identity)
            .id(currentImageIndex)
            .onAppear {
                self.startAnimation()
            }
            .onDisappear {
                self.stopAnimation()
            }
    }

    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            withAnimation {
                self.currentImageIndex = (self.currentImageIndex + 1) % self.images.count
            }
        }
    }

    func stopAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                // Stop the animation immediately
            }
        }
    }
}
func getImage()->[Image]{
    var images: [Image] = [Image("SPLASH PNG SEQ000")]
    
    for i in 1..<355 {
        images.append(Image("SPLASH PNG SEQ\(String(format: "%03d", i))"))
    }
    return images
}

