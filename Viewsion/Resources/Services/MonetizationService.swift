//
//  MonetizationService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/2/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

class MonetizationService {
    
    func CreateAccountLink(completion: @escaping (Result<String,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/payout" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(String.self, from: data),
                  let accountLinkUrl = json as? String
            else {
                print(response)
                completion(.failure(.monetizationAcctLinkNotCreated))
                return
            }
            print("Account Link: \(accountLinkUrl)")
            completion(.success(json))
        }.resume()
    }
    
    func UpdateAccountLink(completion: @escaping (Result<String,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/payout/update/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(String.self, from: data),
                  let accountLinkUrl = json as? String
            else {
                print(response)
                completion(.failure(.monetizationAcctLinkNotCreated))
                return
            }
            print("Account Link: \(accountLinkUrl)")
            completion(.success(json))
        }.resume()
    }
    
    func AccountExists(completion: @escaping (Result<Bool,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/payout/account/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self, from: data)
            else {
                print(response)
                completion(.failure(.monetizationAcctLinkNotCreated))
                return
            }
            completion(.success(json))
        }.resume()
    }
}
