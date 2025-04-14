//
//  CreatorService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation


final class CreatorService {
    
    func GetAllMovies(creatorId: String, completion: @escaping (Result<[Movie],ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/creator/movies/" + creatorId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Movie].self, from: data) else {
                      print("Failed to retrieve Creator data from server.")
                      completion(.failure(.allMoviesListNotDownloaded))
                      return
                  }
            print("Successfully retrieved Creator data.")
            completion(.success(json))
        }
    }
    
    func GetAllHighlights(creatorId: String, completion: @escaping (Result<[Movie],ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/creator/highlights/" + creatorId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Movie].self, from: data) else {
                      print("Failed to retrieve Creator data from server.")
                      completion(.failure(.allMoviesListNotDownloaded))
                      return
                  }
            print("Successfully retrieved Creator data.")
            completion(.success(json))
        }
    }
    
    func GetCreators(completion: @escaping (Result<[Creator],ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/creator/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Creator].self, from: data) else {
                      print(response)
                      print("Failed to retrieve Creator data from server.")
                      completion(.failure(.creatorsViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Creator data.")
            completion(.success(json))
        }.resume()
    }
}
