//
//  MonetizationSettingsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/2/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import WebKit

struct MonetizationSettingsView: View {
    @ObservedObject var monetizationViewModel =  MonetizationSettingsViewModel()
    @State var isLinkPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if(!monetizationViewModel.accountLinkUrl.isEmpty && isLinkPresented) {
                    WebView(request: URLRequest(url: URL(string:monetizationViewModel.accountLinkUrl)!))
                }
                Spacer()
                Button(action: {
                    monetizationViewModel.createAccountLink()
                    isLinkPresented.toggle()
                }, label: {
                    Text("Create Account")
                        .font(.title)
                        .disabled(monetizationViewModel.connected)
                })
                Spacer()
                Button(action: {
                    monetizationViewModel.updateAccountLink()
                    isLinkPresented.toggle()
                }, label: {
                    Text("Update Account")
                        .font(.title)
                        .disabled(!monetizationViewModel.connected)
                })
                Spacer()
            }
            .navigationTitle("Stripe Account")
        }
    }
}

struct MonetizationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MonetizationSettingsView()
    }
}
