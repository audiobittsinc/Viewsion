//
//  StoreService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

final class PaymentService {
    
    
    func GetProducts(userId: UserId, completion: @escaping (Result<Home,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/home")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userId.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Home.self, from: data) else {
                      print(response)
                      completion(.failure(.homeViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Home data.")
            completion(.success(json))
        }.resume()
    }
    
    func GetPurchased(userId: UserId, completion: @escaping (Result<Home,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/home")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userId.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Home.self, from: data) else {
                      print(response)
                      completion(.failure(.homeViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Home data.")
            completion(.success(json))
        }.resume()
    }
    
    func CreatePurchase(userId: UserId, completion: @escaping (Result<Home,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/home")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userId.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Home.self, from: data) else {
                      print(response)
                      completion(.failure(.homeViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Home data.")
            completion(.success(json))
        }.resume()
    }
}
