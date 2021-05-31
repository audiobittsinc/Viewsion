//
//  MembershipView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Segmented control for Watch Now, Watch Later
// 2. List the videos under each segment
// 3. Nav bar search button to search videos in list

import SwiftUI

struct MembershipView1: View {
    var categoryName: String
    var items: [Video]
    
    var body: some View {
        NavigationView {
            List{
                ForEach(items) { movie in
                    NavigationLink(destination: ExperienceView3(video: movie)) {
                        MovieListItem(movie: movie)
                    }
                }
            }
            .navigationTitle("Watch List")
        }
    }
}

struct MembershipView1_Previews: PreviewProvider {
    static var videos = ModelData().videos
    
    static var previews: some View {
        MembershipView1(categoryName: videos[0].category.rawValue, items: Array(videos.prefix(3)))
    }
}
