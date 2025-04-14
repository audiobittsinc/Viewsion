//
//  SignInViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI
class SignInViewModel: ObservableObject {
    @Published var user: SignInResponse?
    @Published var isAuthenticated: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    private var service: RegistrationService
    
    init() {
        self.isAuthenticated = false
        service = RegistrationService()
    }
    
    func Authenticate(user: UserSignIn) -> Void {
        service.Authenticate(user: user) { result in
            
            switch result {
            case .success(let session):
                UserDefaults.standard.setValue(session.token, forKey: "token")
                UserDefaults.standard.setValue(session.userId, forKey: "userid")
                DispatchQueue.main.sync {
                    self.user = session
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func Authorize() {
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }
}
