//
//  SignUpViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var user: User?
    @Published var userIsLoggedIn: Bool?
    
    private var service: RegistrationService
    
    init() {
        service = RegistrationService()
    }
    
    func Create(user: User) -> Void {
    }
    
    func isUserAuthenticated() -> Bool {
        userIsLoggedIn = true
        return true
    }
}
