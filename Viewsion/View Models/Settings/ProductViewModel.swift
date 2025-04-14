//
//  ProductViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var emojis: [Emoji]?
    
    var service: ProductService?
    
    init() {
        service = ProductService()
    }
    
    func Get() {
        ProductService.products
    }
}
