//
//  RegistrationView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/6/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authenticator: Authenticator
    @State private var isReturningUser = false
    
    var body: some View {
        VStack {
            if !isReturningUser {
                SignUpView()
                HStack {
                    Text("Already a user?")
                        .edgesIgnoringSafeArea(.all)
                    Button("Sign In") {
                        isReturningUser.toggle()
                    }
                }
            } else {
                SignInView()
                HStack {
                    Text("Create an account")
                        .edgesIgnoringSafeArea(.all)
                    Button("Sign Up") {
                        isReturningUser.toggle()
                    }
                }
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(Authenticator())
    }
}
