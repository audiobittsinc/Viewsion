//
//  ExperienceView4.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//
// 1. Get the two lists of movies and display them here
// 2. Add download button to Now Playing movies and Watch List movies
// 3. Store the movies and their links in coredata

import SwiftUI

struct ExperienceView4: View {
    @State private var selection = 0
    //@State private var data = items
    
    var status: String
    var items: [Video]
    
    var body: some View {
        NavigationView {
        VStack {
        
            
            Picker("Video Queue", selection:
                    $selection, content: {
                        Text("Watch Now").tag(0)
                        Text("Watch Later").tag(1)
                    }).pickerStyle(SegmentedPickerStyle())
                //.padding(15)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                VStack {
//                    Text("This is a movie")
//                        .font(.title)
                    List{
                        ForEach(items) { movie in
                            NavigationLink(destination: ExperienceView3(video: movie)) {
                                MovieListItem(movie: movie)
                            }
                        }
                    }
                }.navigationTitle("Now Playing")
            }
        }
    }
}

struct ExperienceView4_Previews: PreviewProvider {
    static var videos = ModelData().videos
    
    static var previews: some View {
        ExperienceView4(status: videos[0].status.rawValue, items: Array(videos.prefix(5)))
    }
}
