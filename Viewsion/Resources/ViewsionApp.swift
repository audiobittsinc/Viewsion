//
//  ViewsionApp.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

let BackendUrl =  "https://moviesource-devteam-v01.azurewebsites.net" //"http://localhost:5000"
var vUserId: String = ""
var vUsername: String = ""
var vToken: String = ""

@main
struct ViewsionApp: App {
    @StateObject var authenticator = Authenticator()

    init() {
        
        if let defaultUserId = UserDefaults.standard.string(forKey: "userid"), let defaultToken = UserDefaults.standard.string(forKey: "token"), let defaultUsername = UserDefaults.standard.string(forKey: "username") {
            vUserId = defaultUserId
            vUsername = defaultUsername
            vToken = defaultToken
        } else {
            print("No userId initialized")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authenticator)
        }
    }
}
