//
//  EmojiService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class EmojiService {
    
    init() {
        
    }
    
    func Get(completion: @escaping (Result<[Emoji], ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/emoji/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Emoji].self, from: data) else {
                      print(response)
                      completion(.failure(.emojiViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Emoji data.")
            completion(.success(json))
        }
        task.resume()
    }
}
