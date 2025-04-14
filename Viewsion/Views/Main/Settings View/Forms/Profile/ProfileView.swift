//
//  ProfileView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var website: String = ""
    @State private var email: String = ""
    @State private var twitter: String = ""
    @State private var location: String = ""
    @State private var termsAccepted: Bool = false
    @State private var age: Int = 20
    @State private var galleryFileUrl: URL = URL(fileURLWithPath: "")
    @State private var showGalleryPicker = false
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var imageUrl: URL?
    @State private var image: Image?
    
    var body: some View {
        Form {
            Group {
                VStack {
                    Spacer()
                    if image != nil {
                        image?
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200, alignment: .center)
                    } else {
                        Image("profile_placeholder")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                    Spacer()
                    HStack {
                        Text("Name:")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    TextField("Name",
                              text: $name)
                        .foregroundColor(.secondary)
                }
                VStack{
                    Spacer()
                    HStack {
                        Text("Bio:")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    TextField("Bio", text: $bio)
                        .foregroundColor(.secondary)
                }
                VStack{
                    Spacer()
                    HStack {
                        Text("Website:")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    TextField("Website", text: $website)
                        .foregroundColor(.secondary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                VStack{
                    Spacer()
                    HStack {
                        Text("Twitter:")
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    TextField("Twitter", text: $twitter)
                        .foregroundColor(.secondary)
                }
                Group {
                    VStack {
                        Spacer()
                        HStack {
                            Button("Import Pic From Gallery") {
                                showingImagePicker = true
                            }
                            Spacer()
                        }
                        
                    }
                }
                if self.isUserInformationValid() {
                    HStack {
                        Button(action:
                                {
                            // Fill form details
                            formToProfile()
                            // Post to server
                            vm.SaveProfile(profile: vm.profile, imageURL: imageUrl!)
                        }, label: {
                            Text(vm.isUploading ? "Please wait" : "Update Profile")
                                .font(.title)
                        }).disabled(isUpdateDisabled)
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .opacity(vm.isUploading ? 1.0 : 0.0)
                    }
                }
            }
            .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
        }.navigationTitle("Profile")
            .font(.title3)
            .background(Color.blue)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ProfileImagePicker(image: self.$inputImage, url: self.$imageUrl)
            }
    }
    
    private var isUpdateDisabled: Bool {
        vm.isUploading
    }
    
    private func isUserInformationValid() -> Bool {
        if name.isEmpty {
            return false
        }
        
        if bio.isEmpty {
            return false
        }
        
        if website.isEmpty {
            return false
        }
        
        if twitter.isEmpty {
            return false
        }
        
        return true
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func formToProfile() {
        self.vm.profile.creatorId = vUserId
        self.vm.profile.displayName = name
        self.vm.profile.bio = bio
        self.vm.profile.website = website
        self.vm.profile.twitterId = twitter
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
    }
}

struct Location {
    static let allLocations = [
        "New York",
        "London",
        "Tokyo",
        "Berlin",
        "Paris"
    ]
}
