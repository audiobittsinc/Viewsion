//
//  MovieListItem.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct MovieListItem: View {
    var movie: Video
    
    var body: some View {
        HStack {
            movie.image
                .resizable()
                .frame(width: 160, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
            VStack {
                Text(movie.title)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: .leading)
                Text(movie.duration)
                    .foregroundColor(.secondary)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 20, alignment: .leading)
            }
            
        }
        
    }
}

struct MovieListItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItem(movie: ModelData().videos[0])
    }
}
