//
//  ProfileComboView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 2/9/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ProfileComboView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .padding()
                Text("Denzil D'sa")
                Text("CEO")
                Text("AudioBitts Inc")
                HStack {
                    List {
                        NavigationLink("SOCIAL") {
                            
                        }.padding()
                        NavigationLink("COLLECTION") {
                            
                        }.padding()
                        NavigationLink("NEW") {
                            
                        }.padding()
                        NavigationLink("SETTINGS") {
                            
                        }.padding()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ProfileComboView()
}
