//
//  Combined.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//

import SwiftUI

struct Combined: View {
    var body: some View {
        
        ZStack {
            VideoView().ignoresSafeArea()
            
            VStack {
                VStack {
                    TimerView()
                        .offset(y: 170)
                    VerticalCapsuleButton()
                        .offset(y: -30)
                    
                }
                .offset(x:-150)
                ButtonMusicView()
                    .offset(y:-45)
                    .onTapGesture {
                        
                    }
            }
            
        }

    }
}

struct VideoView: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController()

        return vc
    }
}

#Preview {
    Combined()
}
