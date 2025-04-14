//
//  HomeService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

enum ViewError: Error {
    case homeViewNotDownloaded
    case thankyouViewNotDownloaded
    case creatorsViewNotDownloaded
    case reactionsNotDownloaded
    case reactionNotCreated
    case reactionNotUpdated
    case reactionNotDeleted
    case monetizationAcctLinkNotCreated
    case emojiViewNotDownloaded
    case profileNotSaved
    case profileNotFound
    case myMoviesListNotDownloaded
    case myProductsNotDownloaded
    case productNotCreated
    case allMoviesListNotDownloaded
    case movieNotCreated
    case thankyouMovieDoesNotExist
    case pictureNotDeleted
}

final class HomeService {
    
    func Get(completion: @escaping (Result<Home,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/home")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Home.self, from: data) else {
                print(response as Any)
                      completion(.failure(.homeViewNotDownloaded))
                      return
                  }
            print("Successfully retrieved Home data.")
            completion(.success(json))
        }.resume()
    }
}
