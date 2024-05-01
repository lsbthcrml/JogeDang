//
//  GaugeBar.swift
//  JogeDang
//
//  Created by Graciella Adriani Seciawanto on 01/05/24.
//

import SwiftUI


struct GaugeBar: View {
    @Binding var danceTime: TimeInterval
    var totalTime: TimeInterval
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Capsule()
                .frame(width: 22, height: 400)
                .foregroundColor(Color.gray.opacity(0.1))
                .overlay(
                    Capsule()
                        .stroke(Color.black.opacity(1), lineWidth: 6)
                        .overlay(
                            Capsule()
                                .stroke(Color.white, lineWidth: 5)
                        )
                )
  
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.darkblue, Color.neonpurple, Color.neonpink, Color.neonyellow, Color.neongreen]), startPoint: .bottom, endPoint: .top))
                .frame(width: 20, height: danceTime / 70 * 400)
                .mask(alignment: .bottom) {
                    Capsule()
                        .frame(width: 20, height: 400)
                }
            
            
//            Capsule()
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.darkblue, Color.neonpurple, Color.neonpink, Color.neonyellow, Color.neongreen]), startPoint: .bottom, endPoint: .top))
////                .frame(width: 20, height: CGFloat( danceTime / totalTime * 400))
//                .frame(width: 20, height: 450)
//                .alignmentGuide(.bottom) { dimension in
//                    dimension[.bottom]
//                }
        }
    }
}

//#Preview {
//    GaugeBar()
//}
