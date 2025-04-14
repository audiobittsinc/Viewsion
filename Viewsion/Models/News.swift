//
//  News.swift
//  Viewsion
//
//  Created by Denzil Dsa on 1/28/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct News: Codable, Hashable, Identifiable {
    var id: String?
    var creatorId: String?
    var title: String?
    var description: String?
    var body: String?
    var category: String? = "News" //Category "Movie" "Highlight" "Thank you" "News"
    var keywords: [String]?
    var image: [String]?
    var video: [String]?
}
