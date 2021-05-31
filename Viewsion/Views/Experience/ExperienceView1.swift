//
//  ExperienceView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Video tiles
// 2. Nav bar with search button
// 3. Viewing a video turns fullscreen with forward and reverse left and right scroll. Down will close full screen.
// 4. Organize the dashboard with highlights on the timeline
// 5. Each video is under a section header, has a name, touching the name brings up movie profile with all details. Social features coming in update on the movie profile page
// 6. Watch Now, Watch Later, Add to Playing List on profile page top line under cover image (Name and details below)
// 7. Search button searches for name and displays on search screen

import SwiftUI

struct ExperienceView1: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            List{
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Home")
            
            }
        .background(Color.gray)

    }
}

struct ExperienceView1_Previews: PreviewProvider {
    
    static var previews: some View {
        ExperienceView1()
            .environmentObject(ModelData())
    }
}

