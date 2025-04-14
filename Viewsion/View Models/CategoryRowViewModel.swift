//
//  CategoryRowViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class CategoryRowViewModel: ObservableObject {
    @Published var categoryName: String?
    @Published var items: [Movie]?
    var movieItems: [Movie]?
    var movieData: [Video]?
    
    init(category: String, items: [Movie]) {
        self.categoryName = category
        self.items = items
    }
    
    func LoadMoviesIntoVideoForPlayer(key: Int, movies: [Movie]) -> [Video] {
        var selectedIndex: Int = key
        var id: Int = 0
        var videos: [Video] = [Video]()
        for movieIndex in movies.indices {
            if(selectedIndex == movieIndex) {
                videos.append(Video(id: movieIndex, player: AVPlayer(url: URL(string: movies[movieIndex].originalUrl!)!), replay: false, movie: movies[movieIndex]))
                selectedIndex += 1
                id += 1
            }
        }
        return videos
    }
}
