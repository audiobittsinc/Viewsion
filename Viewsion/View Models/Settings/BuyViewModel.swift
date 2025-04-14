//
//  BuyViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class BuyViewModel: ObservableObject {
    @Published var myProduct: MyProduct // Product document for purchased product
    var storeService: StoreService
    var productPurchasedSuccessfully: Bool
    
    init(myProduct: MyProduct) {
        self.myProduct = myProduct
        storeService = StoreService()
        productPurchasedSuccessfully = false
    }
    
    func BuyNow(product: MyProduct) {
        
        
    }   
}
