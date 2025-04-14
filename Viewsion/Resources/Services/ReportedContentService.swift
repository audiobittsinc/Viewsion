//
//  ReportedContentService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/30/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

enum ContentModerationError: Error {
    case reportNotCreated
}

final class ReportedContentService {
    
    func Create(report: ReportedContent, completion: @escaping (Result<Bool,ContentModerationError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/contentmoderation")
        
        let content = try? JSONEncoder().encode(report)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = content
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self,from: data)
            else {
                print(response ?? "Failed to report content.")
                completion(.failure(.reportNotCreated))
                return
            }
            completion(.success(json))
        }.resume()
    }
}
