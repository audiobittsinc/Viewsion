//
//  User.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Codable, Hashable, Identifiable {
    struct Public: Codable {
      let username: String
      let id: Int
      //let createdAt: Date?
      //let updatedAt: Date?
    }
    
    var id: Int?
    var username: String
    var email: String
    var createdAt: Date?
    var updatedAt: Date?
    

}
