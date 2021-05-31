//
//  CategoryRow.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Video]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { video in
                        NavigationLink(destination: ExperienceView3(video: video)) {
                        CategoryItem(video: video)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var videos = ModelData().videos
    
    static var previews: some View {
        CategoryRow(
            categoryName: videos[0].category.rawValue, items: Array(videos.prefix(3))
        )
    }
}
