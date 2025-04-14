//
//  PlayerService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation


final class PlayerService {
    
    func Get(movieId: MovieId, completion: @escaping (Player) -> Void) {
        let url = URL(string: BackendUrl + "/api/player")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(movieId)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Player.self, from: data) else {
                print("Failed to retrieve Player data from server.")
                return
            }
            print("Successfully retrieved Player data.")
            completion(json)
        }
    }
}
