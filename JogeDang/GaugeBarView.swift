//
//  GaugeBarView.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//

import SwiftUI

struct VerticalCapsuleButton: View {
    @State private var fillAmount: CGFloat = 0.0
    let totalAnimationDuration: TimeInterval = 20.0
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: 30, height: 250)
                .foregroundColor(Color.gray.opacity(0.1))
                .overlay(
                    Capsule()
                        .stroke(Color.pink.opacity(0.4), lineWidth: 4))
            
            LinearGradient(gradient: getGradientColors(), startPoint: .bottom, endPoint: .top)
                .mask(
                    Capsule()
                        .frame(width: 26, height: 245 * fillAmount)
                )
               .animation(Animation.linear(duration: totalAnimationDuration))
        }
        .onAppear {
            fillAmount = 1.0
        }
    }
    
    func getGradientColors() -> Gradient {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .red]
        let colorStops: [Gradient.Stop] = (0..<colors.count).map { index in
            let stop = Gradient.Stop(color: colors[index], location: CGFloat(index) / CGFloat(colors.count - 1))
            return stop
        }
        return Gradient(stops: colorStops)
    }
}

#Preview {
        VerticalCapsuleButton()
    }

