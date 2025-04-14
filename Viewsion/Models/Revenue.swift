//
//  Revenue.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct Revenue: Codable, Hashable, Identifiable {
    var id: Int?
    var userId: Int
    var revenueStream: RevenueStream
    var amount: Int
    var date: Date?
    var isRecurring: Bool
    
    enum RevenueStream: String, CaseIterable, Codable {
        case digitalGoods
        case subscription
        case rent
        case buy
    }
}
