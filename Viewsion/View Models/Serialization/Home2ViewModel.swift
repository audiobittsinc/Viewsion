//
//  Home2ViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 1/28/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

/// The Home 2 View Model prepares the Home Stream, which is an organized vertically and horizontally scrollable grid of videos in X and Y rows.

class Home2ViewModel: ObservableObject {
    @Published var home: Home2?
    @Published var videos: [Video]?
    private var service: Home2Service?
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
        service = Home2Service()
    }
    
    func Get() {
        service?.Get() { result in
            switch result {
            case .success(let homeRes):
                DispatchQueue.main.async { [self] in
                    home = homeRes
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
