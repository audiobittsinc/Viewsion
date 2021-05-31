//
//  Video.swift
//  Viewsion
//
//  Created by Denzil Dsa on 4/29/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct Video: Hashable, Codable, Identifiable {
    let id: Int
    let username: String
    let title: String
    let synopsis: String
    let duration: String
    let video: Data
    let isFeatured: Bool
    let isFavorite: Bool
    let cast: [String]
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
            case latest = "Latest"
            case action = "Action"
            case animated = "Animated"
            case adventure = "Adventure"
        }
    
    private var imageName: String
    var image: Image {
            Image(imageName)
        }
    
    var movieScreenshots: [String]
    
    var status: Status
    enum Status: String, CaseIterable, Codable {
        case watchNow = "Watch Now"
        case watchLater = "Watch Later"
    }
}
