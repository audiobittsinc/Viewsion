//
//  ProfileViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile = Profile()
    @Published var isUploading: Bool = false
    var service: ProfileService?
    
    init() {
        service = ProfileService()
    }
    
    func Get(creatorId: String) {
        if(vUserId == "") {
            return
        }
        service?.Get(creatorId: creatorId, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.profile = session
                }
            case .failure(let error):
                print(error)
                return
            }
        })
    }
    
    func Create(pProfile: Profile) {
        self.isUploading = true
        service?.Create(profile: pProfile, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.profile = session
                    self.isUploading = false
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.isUploading = false
                }
                return
            }
        })
    }
    
    func Update(pProfile: Profile) {
        self.isUploading = true
        service?.Update(profile: pProfile, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.profile = session
                    self.isUploading = false
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.isUploading = false
                }
                return
            }
        })
    }
    
    func SaveProfile(profile: Profile, imageURL: URL) {
        service?.SaveProfile(profile: profile, imageURL: imageURL, completion: { _ in
        })
    }
}
