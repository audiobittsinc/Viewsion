//
//  MyMovieViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class MyMoviesViewModel: ObservableObject {
    @Published var myMovies: [Movie] = []
    var service: MovieService
    var userId: String = ""
    
    init() {
        service = MovieService()
    }
    
    func GetMyMovies() {
        service.GetMyMovies() { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.myMovies = movies
                }
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func Delete(movieId: String) {
        service.DeleteMovie(movieId: movieId)
    }
}
