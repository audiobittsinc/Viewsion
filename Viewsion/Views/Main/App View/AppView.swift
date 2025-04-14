//
//  AppView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/6/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            Home2View()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Creators2View()
                .tabItem {
                    Label("Creators", systemImage: "video.fill.badge.checkmark")
                }
            ThankYou2View()
                .tabItem {
                    Label("Thank you", systemImage: "suit.heart.fill")
                }
            Settings2View()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .background(Color.clear)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(Authenticator())
    }
}
