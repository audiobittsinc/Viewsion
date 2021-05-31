//
//  ManagementView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Panning Video cover image
// 2. Movie details below
// 3. Price and budget details
// 4. Bidding details

import SwiftUI

struct ManagementView1: View {
    var videos: [Video]
    var body: some View {
        NavigationView {
            List {
                ForEach(videos) {video in
                    NavigationLink(
                        destination: SaleDetailsListItem(video: video),
                        label: {
                            Text(video.title)
                        })
                    
                }
            }.navigationTitle("Videos for sale")
        }
    }
}

struct ManagementView1_Previews: PreviewProvider {
    static var previews: some View {
        ManagementView1(videos: ModelData().videos)
    }
}
