//
//  BuyView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct BuyView: View {
    var product: Product // Product details
    @ObservedObject var viewModel: BuyViewModel
    
    init(prod: Product) {
        product = prod
        viewModel = BuyViewModel(myProduct: MyProduct(userId: vUserId, productId: prod.productId, quantity: 50))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image(product.productId!)
                        .resizable()
                        .frame(width: 300, height: 200, alignment: .center)
                        .padding()
                    Text(String(format: "Price: $%.02f", product.price!))
                    Button(action: {
                        viewModel.BuyNow(product: viewModel.myProduct)
                    }, label: {
                        Text("Buy")
                            .padding()
                            .border(Color.black)
                    })
                }
            }.navigationTitle(product.title!)
        }
    }
}

struct BuyView_Previews: PreviewProvider {
    static let product = Product()
    static var previews: some View {
        BuyView(prod: product)
    }
}
