//
//  Testing.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 01/05/24.
//
import SwiftUI
import AVKit

struct InterfaceView: View {
    @State private var elapsedTime: TimeInterval = 0.0
    @State private var isMusicPlaying = false
    let totalTime: TimeInterval = 70.0
    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var timerValue: Double = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var isButtonPressed = false // State untuk menandai apakah tombol ditekan
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 10)
                    .opacity(0.3)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timerValue / totalTime))
                    .stroke(Color.neonpink, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 0.1))
            }
            .offset(x: -150, y: 75)
            .frame(width: 30, height: 30)
            
            Spacer()
            
            ZStack(alignment: .bottom) {
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
                    .frame(width: 20, height: CGFloat(elapsedTime / totalTime * 400))
                    .alignmentGuide(.bottom) { dimension in
                        dimension[.bottom]
                    }
            }
            .offset(x: -150, y: 40)
            
            Spacer()
            
            Button(action: {
                if !self.isButtonPressed { // Tombol ditekan
                    self.isButtonPressed = true
                    self.toggleAudio()
                    self.startTimer()
                } else { // Tombol dilepaskan
                    self.isButtonPressed = false
                    self.toggleAudio()
                    self.resetTimer()
                }
            }) {
                Image(isPlaying ? "RETURN" : "BUTTON")
                    .font(.system(size: 100))
                    .foregroundColor(isPlaying ? .green : .pink)
                    .opacity(isButtonPressed ? 0 : 1) // Mengatur opasitas tombol
            }
            
            Spacer()
        }
        .onReceive(timer) { _ in
            if self.isButtonPressed { // Timer hanya berjalan jika tombol ditekan
                if self.timerValue < self.totalTime {
                    self.timerValue += 0.1
                } else {
                    self.timerValue = 0.0
                }
            }
        }
    }
    
    func startTimer() {
        if self.isButtonPressed { // Timer hanya dimulai jika tombol ditekan
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if self.elapsedTime < self.totalTime {
                    self.elapsedTime += 0.1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
    func resetTimer() {
        self.elapsedTime = 0.0
    }
    
    func toggleAudio() {
        if isMusicPlaying {
            // Stop music
            audioPlayer?.stop()
            isMusicPlaying = false
        } else {
            // Start music
            isMusicPlaying = true
            if let soundURL = Bundle.main.url(forResource: "lagu1", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.play()
                } catch {
                    print("Tidak dapat memutar audio: \(error.localizedDescription)")
                }
            } else {
                print("File audio tidak ditemukan")
            }
        }
    }
}


#Preview {
    InterfaceView()
}
