//
//  MyProduct.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct MyProduct: Codable, Hashable, Identifiable {
    var id: String?
    var userId: String?
    var productId: String?
    var quantity: Int?    
}
