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
            VideoView()
            VStack {
                VStack {
                    TimerView()
                    VerticalCapsuleButton()
                    
                }
                .offset(x:-150)
                ButtonMusicView()
                //                    .offset(y:130)
            }
        }
        //        VStack{
        //
        //            Spacer()
        //            HStack {
        //
        //                VStack {
        //                    VideoView()
        //                    TimerView()
        //                    VerticalCapsuleButton()
        //                }
        //                Spacer()
        //
        //            }
        //
        //            Spacer()
        //            ButtonMusicView()
        //        }
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
