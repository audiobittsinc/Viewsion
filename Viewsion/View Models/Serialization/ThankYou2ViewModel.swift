//
//  ThankYouViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class ThankYouViewModel: ObservableObject {
    @Published var thankYou: ThankYou = ThankYou()
    @Published var video: Video?
    @Published var movie: Movie = Movie()
    
    private var service: ThankYouService
    
    init() {
        service = ThankYouService()
    }
    
    func Get() {
        if (vUserId == "") {
            return
        }
        service.Get() { result in
            switch result {
            case .success(let view):
                DispatchQueue.main.async {
                    self.thankYou = view
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func LoadMovieIntoVideoForPlayer(key: Int, movie: Movie) -> Video {
        var video: Video?
        video = Video(id: key, player: AVPlayer(url: URL(string: movie.originalUrl!)!), replay: false, movie: movie)
        return video!
    }
}
