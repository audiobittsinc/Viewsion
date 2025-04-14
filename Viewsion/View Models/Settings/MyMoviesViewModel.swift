//
//  MyMovieViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class MyMoviesViewModel: ObservableObject {
    @Published var myMovies: [Movie]?
    var service: MovieService?
    
    init() {
        service = MovieService()
    }
    func GetMyMovies() {
        
    }
}
