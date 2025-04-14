//
//  HomeViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class HomeViewModel: ObservableObject {
    @Published var home: Home?
    @Published var videos: [Video]?
    private var service: HomeService?
    private var userId: String?
    var user: UserId?
    var categories: [String: [Movie]]?
    {
        if(home != nil)
        {
            return Dictionary(
                grouping: home!.movies!,
                by: { $0.genre! }
            )
        }
        else {
            return nil
        }
    }
    
    init() {
        service = HomeService()
    }
    

    
    func Get() {
        service?.Get() { result in
            switch result {
            case .success(let homeRes):
                DispatchQueue.main.async { [self] in
                    self.home = homeRes
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
