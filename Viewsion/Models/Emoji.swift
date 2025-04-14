//
//  Emoji.swift
//  Viewsion
//
//  Created by Denzil Dsa on 6/21/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct Emoji: Codable, Hashable, Identifiable {
    var id: Int?
    var name: String
    var emojiId: Int
    var userId: Int
    var videoId: Int
    var emojiType: EmojiType
    var emojiUrl: String
    
}
