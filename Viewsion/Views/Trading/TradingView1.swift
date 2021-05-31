//
//  TradingView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. List videos for sale
// 2. Nav Link to budget details with buy button at bottom
// 3. Price summary and confirm buy button
// 4. Payment details and submit button
// 5. Thank you page with success/failure

import SwiftUI

struct TradingView1: View {
    var videos: [Video]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(videos) { video in
                    NavigationLink (
                        destination: TradingView4(video: video)) {
                            Text(video.title)
                        }
                }
            }.navigationTitle("Buy Videos")
        }
        
    }
}

struct TradingView1_Previews: PreviewProvider {
    static var previews: some View {
        TradingView1(videos: ModelData().videos)
    }
}
