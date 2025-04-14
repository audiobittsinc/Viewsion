//
//  ReactionModule.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/25/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct ReactionModule: Decodable {
    var emojis: [Emoji]
    var userReaction: Reaction
    var movieReactions: [Reaction]
}
