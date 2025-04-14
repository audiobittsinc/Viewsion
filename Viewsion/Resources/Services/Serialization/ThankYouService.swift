//
//  ThankYouService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

final class ThankYouService {
    
    func Get(completion: @escaping (Result<ThankYou,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/thankyou/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(ThankYou.self, from: data) else {
                    print(response as Any)
                      completion(.failure(.thankyouViewNotDownloaded))
                      print("Failed to retrieve Thank You data from server.")
                      return
                  }
            print("Successfully retrieved Thank You data.")
            completion(.success(json))
        }.resume()
    }
}
