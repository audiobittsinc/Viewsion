//
//  ContentView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 4/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(){
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            VStack(){
                Text("Hello, World! \n" +
                     "How are you? \n" +
                     "Welcome to Viewsion!")
                    .font(.title)
                    .fontWeight(.medium)
            }.multilineTextAlignment(.center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
