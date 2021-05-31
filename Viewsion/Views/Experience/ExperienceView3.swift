//
//  ExperienceView3.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Movie cover
// 2. Watch Now buttons
// 3. Name/Title
// 4. Duration, Release date
// 5. Synopsis
// 6. Cast
// 7. Images

import SwiftUI

struct ExperienceView3: View {
    @EnvironmentObject var modelData: ModelData
    var video: Video
    
    var videoIndex: Int {
        modelData.videos.firstIndex(where: { $0.id == video.id })!
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack{
                    video.image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                }
                HStack {
                    Text(video.title)
                        .font(.title)
                    
                }
                HStack {
                    Text(video.duration)
                    Spacer()
                    Text(video.category.rawValue)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Button("Watch Now") {
                        ExperienceView2()
                    }
                    Spacer()
                    Button("Add to Queue") {
                        ExperienceView2()
                    }
                }
                Divider()
                
                Text("About \(video.title)")
                    .font(.title2)
                Text(video.synopsis)
                
                Divider()
                Group {
                    Text("Cast")
                        .font(.title2)
                    
                    HStack {
                        ForEach(video.cast, id: \.self){ member in
                            Text(member)
                                .font(.subheadline)
                        }
                    }
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(video.movieScreenshots, id: \.self) { screenshot in
                                Image(screenshot)
                                    .resizable()
                                    .frame(width: 200.0, height: 100.0)
                                    .scaledToFit()
                                
                            }
                        }
                    }
                } 
            }
            .padding()
        }
        .navigationTitle(video.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExperienceView3_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        return ExperienceView3(video: modelData.videos[0])
            .environmentObject(modelData)
    }
}
