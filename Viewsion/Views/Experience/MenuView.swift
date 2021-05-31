//
//  MenuView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/19/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @State var navigated1 = false
    @State var navigated2 = false
    @State var navigated3 = false
    @State var navigated4 = false
    @State var navigated5 = false
    @State var navigated6 = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    
                    NavigationLink(destination: Text("Home")) {
                        CircleButton(buttonLabel: "Home")
                    }
                    
                    NavigationLink(destination: Text("Watch List")) {
                        CircleButton(buttonLabel: "Watch List")
                    }
                }
                
                HStack {
                    
                    NavigationLink(destination: Text("Create")) {
                        CircleButton(buttonLabel: "Create")
                    }
                    
                    NavigationLink(destination: Text("Search")) {
                        CircleButton(buttonLabel: "Search")
                    }
                }
                
                HStack {
                    
                    NavigationLink(destination: Text("Manage")) {
                        CircleButton(buttonLabel: "Manage")
                    }
                    
                    NavigationLink(destination: Text("Analytics")) {
                        CircleButton(buttonLabel: "Analytics")
                    }
                }
            }.navigationTitle("Menu")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()

    }
}

struct CircleButton: View {
    let buttonLabel: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.8))
            Text(buttonLabel)
                .offset(y: -90)
                .accentColor(.white)
        }
    }
}
