//
//  TimerView.swiftui.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
import SwiftUI

struct TimerView: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress / 30))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
//                    .animation(.linear(duration: 30))
                    .onAppear {
                        startTimer()
                    }
                
            }
            .frame(width: 30, height: 50)
            
            Spacer()
        }
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            progress += 1.0
            
            if progress >= 30 {
                timer.invalidate()
            }
        }
    }
}

#Preview {
        TimerView()
    }

