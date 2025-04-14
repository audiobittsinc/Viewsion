//
//  MonetizationSettingsViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/2/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MonetizationSettingsViewModel: ObservableObject {
    @Published var connected: Bool = false
    @Published var accountLinkUrl: String = String()
    let service: MonetizationService
    
    init() {
        service = MonetizationService()
        accountExists()
    }
    
    func createAccountLink() {
        service.CreateAccountLink() { result in
            switch result {
            case .success(let link):
                DispatchQueue.main.async { [self] in
                    self.accountLinkUrl = link
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateAccountLink() {
        service.UpdateAccountLink() { result in
            switch result {
            case .success(let link):
                DispatchQueue.main.async { [self] in
                    self.accountLinkUrl = link
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func accountExists() {
        service.AccountExists() { result in
            switch result {
            case .success(let exists):
                DispatchQueue.main.async { [self] in
                    self.connected = exists
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
