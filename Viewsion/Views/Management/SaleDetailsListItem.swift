//
//  SaleDetailsListItem.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/14/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//
// 2. Movie details below
// 3. Price and budget details
// 4. Bidding details

import SwiftUI

struct SaleDetailsListItem: View {
    var video: Video
    var body: some View {
        VStack {
            video.image
                .resizable()
                .clipped()
                .frame(width: 350, height: 200, alignment: .center)
            Text("Duration: 1:45:36")
            Text("Synopsis: This is the story")
            Text("Cast: Daniel Radcliffe, Emma Watts")
            Text("Total Budget: $15,000")
            Text("Price: $25,000")
            Text("Highest Bid: $10,000")
        }
    }
}

struct SaleDetailsListItem_Previews: PreviewProvider {
    static var previews: some View {
        SaleDetailsListItem(video: ModelData().videos[0])
    }
}
