//
//  Parameters.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct UserId: Codable {
    var userId: String
    var token: String
    
    init(pUserId: String, pToken: String) {
        userId = pUserId
        token = pToken
    }
}

struct MovieId: Codable {
    var userId: String
    var movieId: String
}

struct CreatorId: Codable {
    var userId: String
    var token: String
    var creatorId: String
}

struct ReactionId: Codable {
    var userId: String
    var token: String
    var movieId: String
    var reactionName: String
}

struct Emojis: Decodable {
    var emojis: [Emoji]
}

struct UserSignIn: Codable {
    var email: String
    var password: String
}

struct UserSignUp: Codable {
    var email: String
    var userName: String
    var password: String
}

struct SignInResponse: Decodable {
    var userName: String
    var userId: String
    var token: String
}
