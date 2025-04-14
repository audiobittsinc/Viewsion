//
//  Creator.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/4/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct Creator: Decodable, Hashable {
    var profile: Profile?
    var reactedMovies: [Movie]?
    var thankyouMovie: Movie?
    var highlightMovie: Movie?
}
