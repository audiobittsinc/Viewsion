//
//  HomeViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    //var categoryName: String
    //@Published var movies: [Movie]
    @Published var home: Home?
    
    var categories: [String: [Movie]] {
        Dictionary(
            grouping: home!.movies,
            by: { $0.category! }
        )
    }
    
    init() {
        //categoryName = "Monologue"
        home = Home(movies: [Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 1", description: "Sitting by the window", genre: "N/A", category: "Documentry", keywords: ["Story"], movieUrl: "", posterUrl: "", coverUrl: "https://media.npr.org/assets/img/2017/07/19/bb-01286_wide-80e1fc880848796ea5d4284a4aa5fd511774c0f3-s1600-c85.webp"), Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 2", description: "Sitting by the window", genre: "N/A", category: "Documentry", keywords: ["Story"], movieUrl: "", posterUrl: "", coverUrl: "https://media.npr.org/assets/img/2017/07/19/bb-01286_wide-80e1fc880848796ea5d4284a4aa5fd511774c0f3-s1600-c85.webp"),Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 3", description: "Sitting by the window", genre: "N/A", category: "Movie", keywords: ["Story"], movieUrl: "", posterUrl: "", coverUrl: "https://media.npr.org/assets/img/2017/07/19/bb-01286_wide-80e1fc880848796ea5d4284a4aa5fd511774c0f3-s1600-c85.webp"), Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat 4", description: "Sitting by the window", genre: "N/A", category: "Movie", keywords: ["Story"], movieUrl: "", posterUrl: "", coverUrl: "https://media.npr.org/assets/img/2017/07/19/bb-01286_wide-80e1fc880848796ea5d4284a4aa5fd511774c0f3-s1600-c85.webp")])
        
    }
    
    
}
