//
//  Sign In.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
            TextField("Username",
                text: $username)
        Text("Username minimum 4 characters")
            .foregroundColor(.red)
        TextField("Password",
                text: $password)
        Text("Password minimum 8 characters")
            .foregroundColor(.red)
        NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Sign In")
                    })
                
            }.navigationTitle("Sign In")
        }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
