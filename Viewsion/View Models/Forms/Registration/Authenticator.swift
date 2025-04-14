//
//  Authenticator.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/7/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class Authenticator: ObservableObject {
    @Published var needsAuthentication: Bool
    @Published var isAuthenticating: Bool
    @Published var isAuthenticated: Bool
    private var service: RegistrationService
    
    
    init() {
        self.needsAuthentication = true
        self.isAuthenticating = false
        self.isAuthenticated = false
        service = RegistrationService()
        checkUserAuthentication()
    }
    
    func signIn(user: UserSignIn) {
        self.isAuthenticating = true
        service.Authenticate(user: user) { result in
            switch result {
            case .success(let session):
                UserDefaults.standard.setValue(session.token, forKey: "token")
                UserDefaults.standard.setValue(session.userName, forKey: "username")
                UserDefaults.standard.setValue(session.userId, forKey: "userid")
                vUserId = session.userId
                vUsername = session.userName
                vToken = session.token
                DispatchQueue.main.sync {
                    self.isAuthenticating = false
                    self.needsAuthentication = false
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isAuthenticating = false
                    self.needsAuthentication = true
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func signUp(user: UserSignUp) {
        self.isAuthenticating = true
        service.Create(user: user) { result in
            switch result {
            case .success(let session):
                UserDefaults.standard.setValue(session.token, forKey: "token")
                UserDefaults.standard.setValue(session.userName, forKey: "username")
                UserDefaults.standard.setValue(session.userId, forKey: "userid")
                vUserId = session.userId
                vUsername = session.userName
                vToken = session.token
                DispatchQueue.main.sync {
                    self.isAuthenticating = false
                    self.needsAuthentication = false
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isAuthenticating = false
                    self.needsAuthentication = true
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "userid")
        vUserId = ""
        vToken = ""
        vUsername = ""
        self.isAuthenticated = false
        //self.needsAuthentication = true
    }
    
    func checkUserAuthentication() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let userId = UserDefaults.standard.string(forKey: "userid") else
              {
                  self.needsAuthentication = true
                  self.isAuthenticated = false
                  return
              }
        print("UserId \(userId)")
        self.needsAuthentication = false
        self.isAuthenticated = true
    }
}
