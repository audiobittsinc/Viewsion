//
//  RootView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/7/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ContentView()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Authenticator())
    }
}
