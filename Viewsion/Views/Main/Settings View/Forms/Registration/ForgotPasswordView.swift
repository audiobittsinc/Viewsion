//
//  ForgotPasswordView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email = ""
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    HStack {
                        Text("Enter the email address of your account")
                        Spacer()
                    }
                    TextField("", text: $email)
                        .foregroundColor(.secondary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    HStack {
                        Button(action: {}, label: {
                            Text("Send")
                        })
                        Spacer()
                    }
                }
                .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
            }.padding()
            .navigationTitle("Forgot Password")
            .font(.title2)
            .background(Color.blue)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
