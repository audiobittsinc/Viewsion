//
//  ReactionService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/25/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

final class ReactionService {
    
    func Get(movieId: MovieId, completion: @escaping (Result<ReactionModule,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/reaction")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(movieId)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(ReactionModule.self, from: data) else {
                      print(response)
                      completion(.failure(.reactionsNotDownloaded))
                      return
                  }
            print("Successfully retrieved reactions for movie.")
            completion(.success(json))
        }.resume()
    }
    
    func Create(reaction: Reaction, completion: @escaping (Result<Bool,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/reaction")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(reaction)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self, from: data) else {
                      print(response)
                      completion(.failure(.reactionNotCreated))
                      return
                  }
            print("Successfully created reaction for movie.")
            completion(.success(json))
        }.resume()
    }
    
    func Update(reaction: Reaction, completion: @escaping (Result<Bool,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/reaction")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(reaction)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self, from: data) else {
                      print(response)
                      completion(.failure(.reactionNotUpdated))
                      return
                  }
            print("Successfully updated reaction for movie.")
            completion(.success(json))
        }.resume()
    }
    
    func Delete(reaction: Reaction, completion: @escaping (Result<Bool,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/reaction")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(reaction)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self, from: data) else {
                      print(response)
                      completion(.failure(.reactionNotDeleted))
                      return
                  }
            print("Successfully deleted reaction for movie.")
            completion(.success(json))
        }.resume()
    }
}
