//
//  Profile.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/4/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct Profile: Codable, Hashable, Identifiable {
    var id: String?
    var creatorId: String?
    var displayName: String?
    var bio: String?
    var twitterId: String?
    var website: String?
    var profileImageUrl: String?
}
