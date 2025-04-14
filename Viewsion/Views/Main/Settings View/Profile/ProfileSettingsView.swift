//
//  ProfileSettingsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/25/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ProfileSettingsView: View {
    let vm = ProfileViewModel()
    @State var isEdit = false
    
    init() {
        vm.Get(creatorId: vUserId)
    }
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Spacer(minLength: 15.0)
                if (vm.profile.profileImageUrl == nil) {
                    Image(uiImage: UIImage(systemName: "person.crop.circle")!)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 130, alignment: .center)
                } else {
                    AsyncImage(url: URL(string: (vm.profile.profileImageUrl)!)!, placeholder: {Text("Loading...")}, image: { Image(uiImage: $0).resizable() })
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: .center)
                }
                VStack {
                    HStack {Text("Name:").fontWeight(.bold); Text(vm.profile.displayName ?? "...")}.frame(maxWidth: .infinity, alignment: .leading).padding(2)
                    HStack {Text("Bio:").fontWeight(.bold); Text(vm.profile.bio ?? "...").multilineTextAlignment(.center)}.frame(maxWidth: .infinity, alignment: .leading).padding(2)
                    HStack {Text("Website:").fontWeight(.bold); Text(vm.profile.website ?? "...")}.frame(maxWidth: .infinity, alignment: .leading).padding(2)
                    HStack {Text("Twitter:").fontWeight(.bold); Text(vm.profile.twitterId ?? "...")}.frame(maxWidth: .infinity, alignment: .leading).padding(2)
                    Spacer()
                }.padding()
            }.navigationTitle("Profile")
                .onAppear {
                    vm.Get(creatorId: vUserId)
                }
                .toolbar {
                    Button("Edit"){isEdit.toggle()}
                }
        }
        .sheet(isPresented: $isEdit) {
            ProfileView()
        }

    }
    
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}
