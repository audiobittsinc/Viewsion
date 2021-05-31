//
//  SearchView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Search bar under nav bar
// 2. Search Title, User, Cast segmented control

import SwiftUI

struct SearchView1: View {
    @State private var searchText = ""
    var videos: [Video]
    var body: some View {
        VStack {
            
        SearchBar(text: $searchText)
            .padding(.top, 10)
        
            // List the trending keywords TODO
            
            // This is the list of all videos
            List(videos.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) })) { item in
            Text(item.title)
        }
        }
    }
}


struct SearchView1_Previews: PreviewProvider {
    static var previews: some View {
        SearchView1(videos: ModelData().videos)
    }
}
