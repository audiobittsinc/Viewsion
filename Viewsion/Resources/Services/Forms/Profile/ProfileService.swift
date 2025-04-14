//
//  ProfileService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

class ProfileService: ObservableObject {
    
    func Create(profile: Profile, completion: @escaping (Result<Profile,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/profile/create")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(profile)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Profile.self, from: data) else {
                      print(response as Any)
                      completion(.failure(.profileNotSaved))
                      return
                  }
            print("Successfully created profile.")
            completion(.success(json))
        }.resume()
    }
    
    func UploadPicture(profileId: String, imageURL: URL, completion: @escaping (Result<Profile,UploadError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/profile/upload/" + profileId)
        // generate boundary string using a unique string
        let boundary = UUID().uuidString
        let AuthorizationToken = vToken
        // Set the URLRequest to POST and to the specified URL
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // Content-Type is multipart/form-data, this is the same as submitting form data with file upload
        // in a web browser
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let fileName = imageURL.lastPathComponent
        let mimetype = mimeType(for: fileName)
        let paramName = "photo"
        var fileData: Data?
        do {
            fileData = try Data(contentsOf: imageURL)
        } catch {
            print(error.localizedDescription)
        }
        
        var data = Data()
        // Add the file data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        data.append(fileData!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        // do not forget to set the content-length!
        request.setValue(String(data.count), forHTTPHeaderField: "Content-Length")
        //request.httpBody = try? JSONEncoder().encode(pMovie)
        
        URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Profile.self, from: data) else {
                      print(response as Any)
                      completion(.failure(UploadError.uploadError))
                      return
                  }
            print("Successfully Uploaded Picture")
            print(json)
            completion(.success(json))
        }.resume()
    }
    
    func Get(creatorId: String, completion: @escaping (Result<Profile,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/profile/" + creatorId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Profile.self, from: data) else {
                      print(response as Any)
                      completion(.failure(.profileNotFound))
                      return
                  }
            print("Successfully retrieved profile.")
            completion(.success(json))
        }.resume()
    }
    
    func Update(profile: Profile, completion: @escaping (Result<Profile,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/profile/update")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(profile)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Profile.self, from: data) else {
                      print(response as Any)
                      completion(.failure(.profileNotSaved))
                      return
                  }
            print("Successfully updated profile.")
            completion(.success(json))
        }.resume()
    }
    
    func CreateProfileWithImage(profile: Profile, fileUrl: URL) -> Bool {
        var profileId: String = ""
        
        Create(profile: profile) { result in
            switch result {
            case .success(let profile):
                profileId = profile.id!
            case .failure(let error):
                print(error)
            }
        }
        
        var profileUpload: Profile = Profile()
        
        UploadPicture(profileId: profile.id!, imageURL: fileUrl, completion: { result in
            switch result{
            case .success(let profile):
                profileUpload = profile
            case .failure(let error):
                print(error)
            }
        })
        
        if(!profileUpload.profileImageUrl!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    private func mimeType(for path: String) -> String {
        let pathExtension = URL(fileURLWithPath: path).pathExtension as NSString
        guard
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, nil)?.takeRetainedValue(),
            let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return "application/octet-stream"
        }
        return mimetype as String
    }
    
    func SaveProfile(profile: Profile, imageURL: URL, completion: @escaping (Result<Profile,UploadError>) -> Void) {
        if (profile.id == nil) {
            Create(profile: profile) { result in
                switch result {
                case .success(let prfl):
                    self.UploadPicture(profileId: prfl.id!, imageURL: imageURL) { result in
                        switch result {
                        case .success(let prfl):
                            DispatchQueue.main.async {
                                completion(.success(prfl))
                            }
                        case .failure(let error):
                            print(error)
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            Update(profile: profile) { result in
                switch result {
                case .success(let prfl):
                    self.UploadPicture(profileId: prfl.id!, imageURL: imageURL) { result in
                        switch result {
                        case .success(let prfl):
                            DispatchQueue.main.async {
                                completion(.success(prfl))
                            }
                        case .failure(let error):
                            print(error)
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
