//
//  PlayerView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var data: [Video]
    
    var body: some View {
        VStack {
            Group {
                PlayerHome(viewModel: PlayerViewModel(videoData: data) , index: 0, top: 0, showModalView: false)
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let movies: [Movie] = [Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 1", description: "Sitting by the window", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1"), Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 1", description: "Sitting by the window", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1")]
    
    static let data = [
        
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video4", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1")),
        Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video5", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1")),
        Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video2", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1"))
        
    ]
    static var previews: some View {
        PlayerView(data: data)
    }
}
