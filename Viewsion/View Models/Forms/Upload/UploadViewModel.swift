//
//  UploadViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class UploadViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var movie: Movie = Movie()
    @Published var tyMovie: Movie?
    @Published var movieUpdated: Bool?
    @Published var movieDeleted: Bool?
    @Published var movieCreated: Bool?
    @Published var movieUploaded: Bool = false
    @Published var isUploading: Bool = false
    private var service: UploadService
    
    init() {
        service = UploadService()
    }
    
    func Get(userId: UserId) {
        service.Get(userId: userId) { movies in
            DispatchQueue.main.async {
                self.movies = movies
            }
        }
    }
    
    func Update(movieId: MovieId, movie: Movie) {
        service.Update(movieId: movieId, movie: movie) { updated in
            DispatchQueue.main.async {
                self.movieUpdated = updated
            }
        }
    }
    
    func Delete(movieId: MovieId, movie: Movie) {
        service.Delete(movieId: movieId, movie: movie) { deleted in
            DispatchQueue.main.async {
                self.movieDeleted = deleted
            }
        }
    }
    
    func UploadMovie(movieId: String, movieFileUrl: URL) {
        service.UploadMovieFormData(movieId: movieId, fileURL: movieFileUrl) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.movie = model
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func UploadMovieAndMovieFile(id: String, fileUrl: URL) {
        DispatchQueue.main.async {
            self.movieCreated = self.service.UploadMovieAndMovieFile(movieId: id, fileUrl: fileUrl)
        }
        
        if(movieCreated != nil && movieCreated == true){
            deleteFileAfterUpload(url: fileUrl)
        }
    }
    
    func UploadMovie(movie: Movie, fileURL: URL) {
        DispatchQueue.main.async {
            self.isUploading = true
        }
        service.UploadMovie(movie: movie, fileURL: fileURL) { result in
            switch result {
            case .success(let isUploaded):
                self.deleteFileAfterUpload(url: fileURL)
                DispatchQueue.main.async {
                    self.movieUploaded = isUploaded
                    self.isUploading = false
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.isUploading = false
                }
            }
        }
    }
    
    func GetThankYouMovie() {
        service.GetTyMovieOfCreator { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.tyMovie = movie
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteFileAfterUpload(url: URL) {
        do {
            let fileManager = FileManager.default
            // Check if file exists
            if fileManager.fileExists(atPath: url.path) {
                // Delete file
                try fileManager.removeItem(atPath: url.path)
                print("File deleted from documents: " + url.absoluteString)
            } else {
                print("File does not exist")
            }
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }
    }
}
