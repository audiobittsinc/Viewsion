//
//  Token.swift
//  Viewsion
//
//  Created by Denzil Dsa on 6/21/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

enum SessionSource: Int {
    case signup
    case login
}

struct Token {
    
    var id: Int?
    var user: User
    var value: String
    var source: SessionSource
    var createdAt: Date?
    var updatedAt: Date?
    
}
