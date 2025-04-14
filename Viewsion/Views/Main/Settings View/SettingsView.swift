//
//  SettingsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/29/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authenticator: Authenticator
    @State var isLoginPresented = false
    @ObservedObject var loginVM = SignUpViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                List {
                    NavigationLink(
                        destination: ProfileSettingsView(),
                        label: {
                            Text("Profile")
                        }).listRowBackground(Color.blue)
                        .font(.title3)
                    NavigationLink(
                        destination: MyMoviesView(),
                        label: {
                            Text("Movies")
                        }).listRowBackground(Color.blue)
                        .font(.title3)
                    NavigationLink(
                        destination: AboutView(),
                        label: {
                            Text("About Us")
                        }).listRowBackground(Color.blue)
                        .font(.title3)
                }.navigationTitle("Settings")
                    .toolbar {
                        
                        Button(authenticator.isAuthenticated ? "Sign Out" : "Sign In") {
                            if(authenticator.isAuthenticated == true) {
                                authenticator.logout()
                            } else {
                                authenticator.needsAuthentication = true
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $authenticator.needsAuthentication, content: {
                        RegistrationView()
                            .environmentObject(authenticator)
                    })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Authenticator())
    }
}
