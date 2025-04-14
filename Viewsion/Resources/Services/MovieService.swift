//
//  MovieService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 7/12/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine

enum MovieError: Error {
    case movieNotFound
    case custom(errorMessage: String)
}

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
    
    func GetMyMovies(completion: @escaping (Result<[Movie],ViewError>) -> Void) {
       let url = URL(string: BackendUrl + "/api/movie/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Movie].self, from: data) else {
                completion(.failure(.myMoviesListNotDownloaded))
                return
            }
            completion(.success(json))
        }.resume()
    }
    
    func DeleteMovie(movieId: String) {
       let url = URL(string: BackendUrl + "/api/movie/" + movieId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200
                  else {
                print("Movie delete failed.")
                return
            }
            print("Movie deleted.")
        }.resume()
    }
}

struct MovieDataContainer: Decodable {
    let data: MovieData
}

struct MovieData: Decodable {
    let movies: [Movie]
}



