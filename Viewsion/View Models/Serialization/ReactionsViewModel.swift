//
//  ReactionsViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/16/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class ReactionsViewModel: ObservableObject {
    @Published var reactions: ReactionModule?
    @Published var reactionCreated: Bool?
    @Published var reactionUpdated: Bool?
    @Published var reactionDeleted: Bool?
    var service: ReactionService?
    var movieId: MovieId?
    var products: Product?
    
    var emojiCategories: [String: [Reaction]]?
    {
        if(reactions?.movieReactions != nil)
        {
            return Dictionary(
                grouping: reactions!.movieReactions,
                by: { $0.name! }
            )
        }
        else {
            return nil
        }
    }
    
    init() {
        service = ReactionService()
    }
    
    func Get(movieId: MovieId) {
        service!.Get(movieId: movieId) { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.reactions?.movieReactions = session.movieReactions
                    self.reactions?.userReaction = session.userReaction
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func Create(reaction: Reaction) {
        service?.Create(reaction: reaction, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.reactionCreated = session
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        })
    }
    
    func Update(reaction: Reaction) {
        service?.Create(reaction: reaction, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.reactionUpdated = session
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        })
    }
    
    func Delete(reaction: Reaction) {
        service?.Create(reaction: reaction, completion: { result in
            switch result {
            case .success(let session):
                DispatchQueue.main.async {
                    self.reactionDeleted = session
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        })
    }
}




