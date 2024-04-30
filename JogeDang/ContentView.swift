//
//  ContentView.swift
//  JogeDang
//
//  Created by Elisabeth Carmela on 29/04/24.
//



import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    @State var images: [Image]
    var body: some View {
        
        ZStack{
            if self.isActive{
//                Rectangle()
                Combined()
            } else {
                ImageChanger(images: images)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 14.5) {
                withAnimation{
                    self.isActive = true
                }
            }
        }
        
        
//        ImageChanger(images: images)
//        Combined()
    }
}

#Preview {
    ContentView(images: getImage())
}
