//
//  MovieService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 7/12/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine

final class MovieService {
    
    func fetchMovies() -> AnyPublisher<MovieDataContainer, Error> {
        
        var components: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "localhost:8080"
            components.path = "/movies/index"
            return components
        }
        
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: MovieDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct MovieDataContainer: Decodable {
    let data: MovieData
}

struct MovieData: Decodable {
    let movies: [Movie]
}

