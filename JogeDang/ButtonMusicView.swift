//
//  ButtonMusicView.swiftui.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//


import SwiftUI
import AVKit

struct ButtonMusicView : View {
    
    @State var audioPlayer: AVAudioPlayer?
    @State var isPlaying = false
    
    var body: some View {
        Button(action: {
            self.toggleAudio()
        }) {
            
            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(isPlaying ? .green : .pink)
           
        }
    }
    
    func toggleAudio() {
        if isPlaying {
            audioPlayer?.stop()
            isPlaying = false
        } else {
            if let soundURL = Bundle.main.url(forResource: "lagu1", withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    
                    audioPlayer?.play()
                    isPlaying = true
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
        ButtonMusicView()
    }
