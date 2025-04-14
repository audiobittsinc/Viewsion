//
//  Reaction.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct Reaction: Codable, Hashable, Identifiable {
    var id: String?
    var movieId: String?
    var userId: String?
    var name: String?
    var createdAt: Date?
    var updatedAt: Date?
}

