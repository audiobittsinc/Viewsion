//
//  ContentView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 4/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Authenticator())
    }
}
