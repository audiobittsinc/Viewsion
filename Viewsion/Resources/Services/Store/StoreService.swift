//
//  StoreService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

final class StoreService {
    
    
    func GetPurchasedProducts(completion: @escaping (Result<[MyProduct],ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/product/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([MyProduct].self, from: data) else {
                      print(response)
                      completion(.failure(.myProductsNotDownloaded))
                      return
                  }
            
            print("Successfully retrieved product data.")
            completion(.success(json))
        }.resume()
    }
    
    func Create(product: MyProduct, completion: @escaping (Result<Bool,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/product")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(product)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self, from: data) else {
                      print(response)
                      completion(.failure(.productNotCreated))
                      return
                  }
            
            print("Successfully retrieved Home data.")
            completion(.success(json))
        }.resume()
    }
}
