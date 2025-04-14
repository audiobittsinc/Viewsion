//
//  RegistrationService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

final class RegistrationService {
    
    func Create(user: UserSignUp, completion: @escaping (Result<SignInResponse, AuthenticationError>) -> Void) -> Void {
        let url = URL(string: BackendUrl + "/api/user/signup")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(SignInResponse.self,from: data)
            else {
                print(response ?? "Failed to Sign Up User.")
                completion(.failure(.custom(errorMessage: "Failed to Sign Up User.")))
                return
            }
            completion(.success(json))
        }.resume()
    }
    
    func Authenticate(user: UserSignIn, completion: @escaping (Result<SignInResponse, AuthenticationError>) -> Void) -> Void {
        let url = URL(string: BackendUrl + "/api/user/signin")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(SignInResponse.self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to Sign In User.")
                completion(.failure(.invalidCredentials))
                return
            }
            completion(.success(json))
        }.resume()
    }
}
