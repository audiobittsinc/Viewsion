//
//  PurchaseService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Purchases

class PurchaseService {
    
    static func purchase(productId: String?, successfulPurchase: @escaping () -> Void) {
        guard productId != nil else {
            return
        }
        
        Purchases.shared.products([productId!]) { (products) in
            if !products.isEmpty {
                
                let skProduct = products[0]
                
                //Purchase product
                Purchases.shared.purchaseProduct(skProduct) { transaction, purchaserInfo, error, userCancelled in
                    if error == nil && !userCancelled {
                        
                        //successful purchase
                        successfulPurchase()
                    }
                }
            }
        }
    }
}
