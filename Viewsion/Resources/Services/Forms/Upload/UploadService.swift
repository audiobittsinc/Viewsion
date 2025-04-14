//
//  UploadService.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import MobileCoreServices

enum UploadError: Error {
    case uploadError
    case custom(errorMessage: String)
}

final class UploadService {
    
    func Get(userId: UserId, completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: BackendUrl + "/api/upload")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(userId)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode([Movie].self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to retrieve Movie list.")
                return
            }
            completion(json)
        }.resume()
    }
    
    func Create(movie: Movie, completion: @escaping (Result<Movie,ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/movie")
        
        let encodedMovie = try? JSONEncoder().encode(movie)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = encodedMovie
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Movie.self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to upload Movie.")
                completion(.failure(.movieNotCreated))
                return
            }
            print("Movie created successfully.")
            completion(.success(json))
        }.resume()
    }
    
    func Update(movieId: MovieId, movie: Movie, completion: @escaping (Bool) -> Void) {
        let url = URL(string: BackendUrl + "/api/upload")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to update Movie.")
                return
            }
            completion(json)
        }.resume()
    }
    
    func Delete(movieId: MovieId, movie: Movie, completion: @escaping (Bool) -> Void) {
        let url = URL(string: BackendUrl + "/api/upload")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Bool.self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to delete Movie.")
                return
            }
            completion(json)
        }.resume()
    }
    
    func UploadMovieFormData(movieId: String, fileURL: URL, completion: @escaping (Result<Movie,UploadError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/upload/" + movieId)
        // generate boundary string using a unique string
        let boundary = UUID().uuidString
        // Set the URLRequest to POST and to the specified URL
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // Content-Type is multipart/form-data, this is the same as submitting form data with file upload
        // in a web browser
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let fileName = fileURL.lastPathComponent
        let mimetype = mimeType(for: fileName)
        let paramName = "movie"
        var fileData: Data?
        do {
            fileData = try Data(contentsOf: fileURL, options: NSData.ReadingOptions.mappedIfSafe)
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
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
             guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Movie.self, from: data) else {
                      print(response)
                      completion(.failure(UploadError.uploadError))
                      return
                  }
            print("Successful Upload")
            print(json)
            completion(.success(json))
        }
        task.resume()
        
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
    
    func UploadMovieAndMovieFile(movieId: String, fileUrl: URL) -> Bool {
        
        var movieUpload: Movie = Movie()
        
        self.UploadMovieFormData(movieId: movieId, fileURL: fileUrl, completion: { result in
            switch result{
            case .success(let movie):
                movieUpload = movie
            case .failure(let error):
                print(error)
            }
        })
        
        if(!movieUpload.originalUrl!.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func GetTyMovieOfCreator(completion: @escaping (Result<Movie, ViewError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/upload/thankyou/" + vUserId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Movie.self,from: data)
            else {
                completion(.failure(.thankyouMovieDoesNotExist))
                return
            }
            completion(.success(json))
        }.resume()
    }
    
    func UploadMovie(movie: Movie, fileURL: URL, completion: @escaping (Result<Bool,UploadError>) -> Void) {
        let url = URL(string: BackendUrl + "/api/movie")
        
        let MOVIE = try? JSONEncoder().encode(movie)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = MOVIE
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONDecoder().decode(Movie.self,from: data)
            else {
                print(error?.localizedDescription ?? "Failed to upload Movie.")
                return
            }
            print("Movie created successfully.")
            let newMovieId = json.id
            
            let url = URL(string: BackendUrl + "/api/upload/" + newMovieId!)
            // generate boundary string using a unique string
            let boundary = UUID().uuidString
            _ = vToken
            // Set the URLRequest to POST and to the specified URL
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            // Content-Type is multipart/form-data, this is the same as submitting form data with file upload
            // in a web browser
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let fileName = fileURL.lastPathComponent
            let mimetype = self.mimeType(for: fileName)
            let paramName = "movie"
            var fileData: Data?
            do {
                fileData = try Data(contentsOf: fileURL, options: NSData.ReadingOptions.mappedIfSafe)
            } catch {
                print(error.localizedDescription)
            }
            
            var dataObj = Data()
            // Add the file data to the raw http request data
            dataObj.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            dataObj.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            dataObj.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            dataObj.append(fileData!)
            dataObj.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            // do not forget to set the content-length!
            request.setValue(String(dataObj.count), forHTTPHeaderField: "Content-Length")
            
            URLSession.shared.uploadTask(with: request, from: dataObj) { data, response, error in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                          print(response)
                          self.DeleteMovie(movieId: newMovieId!)
                          completion(.failure(UploadError.uploadError))
                          return
                      }
                print("Successful Movie Upload.")
                completion(.success(true))
            }.resume()
            
        }.resume()
    }
    
    func DeleteMovie(movieId: String) {
       let url = URL(string: BackendUrl + "/api/movie/" + movieId)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(vToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200
                  else {
                print("Movie delete failed.")
                return
            }
            print("Movie deleted.")
        }.resume()
    }
}
