//
//  CreatorViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import AVFoundation

/// The Creator 2 View Model prepares the Creators Stream, which is a stream of videos and a X row of Liked videos above each video.

class Creators2ViewModel: ObservableObject {
    @Published var creators: [Creator] = []
    @Published var video: Video?
    @Published var movie: Movie = Movie()
    @Published var allMovies: [Movie] = []
    @Published var allHighlights: [Movie] = []
    private var service: CreatorService
    
    init() {
        service = CreatorService()
    }
    
    func Get() {
        if (vUserId == "") {
            return
        }
        service.GetCreators() { result in
            switch result {
            case .success(let view):
                DispatchQueue.main.async { [self] in
                    self.creators = view
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func GetAllMovies(creatorId: String) {
        if (vUserId == "") {
            return
        }
        service.GetAllMovies(creatorId: creatorId) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async { [self] in
                    self.allMovies = movies
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func GetAllHighlights(creatorId: String) {
        if (vUserId == "") {
            return
        }
        service.GetAllHighlights(creatorId: creatorId) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async { [self] in
                    self.allHighlights = movies
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func LoadMovieIntoVideoForPlayer(key: Int, movie: Movie) -> Video {
        var video: Video?
        video = Video(id: key, player: AVPlayer(url: URL(string: movie.originalUrl!)!), replay: false, movie: movie)
        return video!
    }
    
    func LoadMoviesIntoVideoForPlayer(key: Int, movies: [Movie]) -> [Video] {
        var selectedIndex: Int = key
        var id: Int = 0
        var videos: [Video] = [Video]()
        for movieIndex in movies.indices {
            if(selectedIndex == movieIndex) {
                videos.append(Video(id: movieIndex, player: AVPlayer(url: URL(string: movies[movieIndex].originalUrl!)!), replay: false, movie: movies[movieIndex]))
                selectedIndex += 1
                id += 1
            }
        }
        return videos
    }
}
