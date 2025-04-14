//
//  StoreView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject var viewModel = StoreViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Buy")){
                    ForEach(viewModel.storeProducts, id:\.self) { product in
                        NavigationLink(
                            destination: BuyView(prod: product),
                            label: {
                                HStack {
                                    Text(product.title!)
                                    Spacer()
                                    Text("Buy")
                                }
                            })
                    }
                }
                Section(header: Text("Purchased")) {
                    List {
                        if (!viewModel.myProducts.isEmpty) {
                            ForEach(viewModel.myProducts, id:\.self) { product in
                                Text(product.productId!.capitalized)
                            }
                        }
                    }
                }
                Section(header: Text("Balance")) {
                    List {
                        if (!viewModel.myProducts.isEmpty) {
                            ForEach(viewModel.balances, id:\.self) { balance in
                                HStack {
                                    Text(balance.productId!.capitalized)
                                    Spacer()
                                    Text(String(balance.quantity!))
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Store")
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
