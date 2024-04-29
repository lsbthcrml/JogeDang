//
//  ContentView.swift
//  JogeDang
//
//  Created by Elisabeth Carmela on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var images: [Image]
    var body: some View {
        ImageChanger(images: images)
    }
}

#Preview {
    ContentView(images: getImage())
}
