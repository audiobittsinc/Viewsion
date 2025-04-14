//
//  Home2Service.swift
//  Viewsion
//
//  Created by Denzil Dsa on 2/6/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import Foundation

final class Home2Service {
    
    func Get(completion: @escaping (Result<Home2,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/home")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Home2.self, from: data) else {
                print(response as Any)
                      completion(.failure(.homeViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Home 2 data.")
            completion(.success(json))
        }.resume()
    }
}
