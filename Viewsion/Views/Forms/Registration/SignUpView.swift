//
//  SignUpView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Email",
                        text: $email)
                Text("Email not formatted correctly")
                    .foregroundColor(.red)
                TextField("Username",
                        text: $username)
                Text("Username minimum 4 characters")
                    .foregroundColor(.red)
                TextField("Password",
                        text: $password)
                Text("Password minimum 8 characters")
                    .foregroundColor(.red)
                TextField("Password Confirm",
                        text: $passwordConfirm)
                Text("Confirm password does not match password")
                    .foregroundColor(.red)
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Sign Up")
                    })
          
            }.navigationBarTitle(Text("Sign Up"))
            
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
