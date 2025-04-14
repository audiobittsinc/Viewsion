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
    var id: String?
    var creatorId: String?
    var title: String?
    var description: String?
    var genre: String?
    var category: String? //Category "Movie" "Highlight" "Thank you"
    var keywords: [String]?
    var originalUrl: String?
    var hlsUrl: String?
}

