//
//  MovieListViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 7/12/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    private let movieService = MovieService()
    
    @Published var movieViewModels = [MovieViewModel]()
    
    var cancellable: AnyCancellable?
    
    func fetchMovies() {
        cancellable = movieService.fetchMovies().sink(receiveCompletion: { _ in
        }, receiveValue: { movieContainer in
            self.movieViewModels = movieContainer.data.movies.map { MovieViewModel(movie: $0) }
            print(self.movieViewModels)
        })
    }
}

struct MovieViewModel: Codable, Hashable {
    private var movie: Movie
    
    var title: String {
        return movie.title!
    }
    
    var mov: Movie {
        return movie
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
