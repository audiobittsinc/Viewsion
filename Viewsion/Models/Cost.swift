//
//  Royalty.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct Cost: Codable, Hashable, Identifiable {
    var id: Int?
    var name: String
    var from: Int
    var to: Int
    var amount: Int
    var videoId: Int
    var costType: CostType
    var date: Date?
    
    enum CostType: String, CaseIterable, Codable {
        case view
        case emoji
        case rent
        case buy
    }
}
