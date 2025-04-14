//
//  Product.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable, Identifiable {
    var id: String?
    var productId: String?
    var title: String?
    var description: String?
    var quantity: Int?
    var price: Int?
    var imageName: String?
}
