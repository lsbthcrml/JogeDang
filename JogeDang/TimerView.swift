//
//  TimerView.swiftui.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.


import SwiftUI

struct TimerView: View {
    @State private var timerValue: Double = 0.0
    let totalTime: Double = 70
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .opacity(0.3)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timerValue / totalTime))
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 0.1))
                
                
            }
            .frame(width: 30, height: 30)
            
            Spacer()
        }
        .onReceive(timer) { _ in
            if self.timerValue < self.totalTime {
                self.timerValue += 0.1
            } else {
                self.timerValue = 0.0
            }
        }
    }
}

#Preview {
    TimerView()
}
