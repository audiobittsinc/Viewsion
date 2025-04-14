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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CreatorsView()
                .tabItem {
                    Label("Creators", systemImage: "video.fill.badge.checkmark")
                }
            ThankYouView()
                .tabItem {
                    Label("Thank you", systemImage: "suit.heart.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
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
