//
//  Combined.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//

import SwiftUI

struct Combined: View {
    @State var danceTime: TimeInterval = 0.0
    
    var body: some View {
        
        ZStack {
          VideoView(danceTime: $danceTime).ignoresSafeArea()
            
            VStack {
                InterfaceView(danceTime: $danceTime)
            }
            
            //insert filter
            
        }

    }
}

struct VideoView: UIViewControllerRepresentable, ViewControllerDelegate {
    @Binding var danceTime: TimeInterval
    
    func addDanceTime(danceTime: TimeInterval) {
        self.danceTime += danceTime
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController()
        vc.delegate = self

        return vc
    }
}

#Preview {
    Combined()
}
