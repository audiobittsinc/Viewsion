//
//  TradingView4.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct TradingView4: View {
    var video: Video
    
    var body: some View {
        NavigationView {
            VStack {
            Text(video.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .navigationTitle("Movie details")
            Text("Budget: $15,000")
            Text("Price: $25,000")
            Divider()
            Text("Payment details")
            Text("VISA: 123 456 7890")
            Button("Buy Now") {
                    TradingView5()
                }
            }
            
        }
    }
}

struct TradingView4_Previews: PreviewProvider {
    static var previews: some View {
        TradingView4(video: ModelData().videos[0])
    }
}
