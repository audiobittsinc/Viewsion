//
//  CreationView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Upload video rectangle button
// 2. Mint video rectangle button
// 3. Monetize video rectangle button

import SwiftUI

struct CreationView1: View {
    var body: some View {
        NavigationView {
        VStack{
            Button(action: {CreationView2()}, label: {
                VStack {
                Rectangle()
                    .frame(width: 350, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                Text("Upload Video")
                    .offset(y: -90)
                    .foregroundColor(.white)
                }
            })
            Button(action: {CreationView2()}, label: {
                VStack {
                Rectangle()
                    .frame(width: 350, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                Text("Monetize Video")
                    .offset(y: -90)
                    .foregroundColor(.white)
                }
            })
            
            Button(action: {CreationView2()}, label: {
                VStack {
                Rectangle()
                    .frame(width: 350, height: 150, alignment: .center)
                    .cornerRadius(10)
                Text("Rent Video")
                    .offset(y: -90)
                    .foregroundColor(.white)
                }
            })
        }.navigationTitle("Create")
        }
    }
}

struct CreationView1_Previews: PreviewProvider {
    static var previews: some View {
        CreationView1()
    }
}
