//
//  VideoStatus.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct VideoStatus: Codable, Hashable, Identifiable {
    var id: Int
    var userId: Int
    var movieId: Int
    var isPaused: Bool
    var status: Status
    
    enum Status: Int, CaseIterable, Codable {
        case watchNow = 1001
        case watchLater = 1002
    }
}


