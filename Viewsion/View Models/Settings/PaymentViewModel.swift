//
//  ProductViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

final class PaymentViewModel: ObservableObject {
    @Published var payments: Payment?
    var service: PaymentService?
    
    init() {
        service = PaymentService()
    }
    
    func GetProducts() {
        
    }
    
    func GetPurchased() {
        
    }
    
    func CreatePurchase() {
        
    }
    
    func GetProductBalance() {
        
    }
}
