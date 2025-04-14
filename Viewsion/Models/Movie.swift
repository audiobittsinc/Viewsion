//
//  Movie.swift
//  Viewsion
//
//  Created by Denzil Dsa on 7/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct Movie: Codable, Hashable, Identifiable {
    var id: Int?
    var producerId: Int
    var title: String
    var videoUrl: String
    var videoThumbnail: String
    var description: String
    var trailerUrl: String
    var duration: String
    var releaseDate: Date?
    var genre: Genre
    var category: [String] //Category Keywords "technology" "music" "video games"
    var poster: String
    var photos: [String]
    var cast: [String]
    var createdAt: Date?
    var updatedAt: Date?
    
}

