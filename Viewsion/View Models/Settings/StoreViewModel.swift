//
//  StoreViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class StoreViewModel: ObservableObject {
    @Published var myProducts: [MyProduct] = []
    @Published var balances: [ProductBalance] = []
    @Published var storeProducts: [Product] = []
    var productAdded: Bool = false
    var service: StoreService
    
    init() {
        service = StoreService()        
        DispatchQueue.main.async { [self] in
            storeProducts = ProductService.products
        }
    }
    
    struct ProductBalance: Codable, Hashable {
        var productId: String?
        var quantity: Int?
    }
    
    func Get() {
        service.GetPurchasedProducts { result in
            switch result {
            case .success(let productList):
                DispatchQueue.main.async {
                    self.myProducts = productList
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func Create(product: MyProduct) {
        service.Create(product: product) { result in
            switch result {
            case .success(let productList):
                DispatchQueue.main.async {
                    self.productAdded = productList
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func GetBalanceForProducts() {
        DispatchQueue.main.async { [self] in
            for index in myProducts.indices {
                balances[index].productId = myProducts[index].productId!
                balances[index].quantity = myProducts[index].quantity!
            }
        }
    }
}
