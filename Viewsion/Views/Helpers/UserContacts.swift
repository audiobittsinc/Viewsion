//
//  UserContacts.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct UserContacts: View {
    var email: String
    var website: String
    var twitter: String
    
    var body: some View {
        VStack {
        Text("Email: \(email)")
        Text("Website: \(website)")
        Text("Twitter: \(twitter)")
        }
    }
}

struct UserContacts_Previews: PreviewProvider {
    static var previews: some View {
        UserContacts(email: "harrypotter@gmail.com", website: "movieexample.com", twitter: "@harrypotter")
    }
}
