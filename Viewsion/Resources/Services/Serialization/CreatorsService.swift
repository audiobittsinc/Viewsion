//
//  CreatorService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation


final class CreatorService {
    
    func Get(creatorId: CreatorId, completion: @escaping (Creator) -> Void) {
        let url = URL(string: BackendUrl + "/api/creator")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(creatorId)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Creator.self, from: data) else {
                print("Failed to retrieve Creator data from server.")
                return
            }
            print("Successfully retrieved Creator data.")
            completion(json)
        }
    }
}
