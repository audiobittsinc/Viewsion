//
//  Store.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable, Identifiable {
    var id: String?
    var productId: String?
    var name: String?
    var units: Int?
    var price: Int?
    var quantity: Int?
    var userId: String?
    
}
