//
//  CreatorAllMoviesView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CreatorAllMoviesView: View {
    private var colors: [Color] = [.blue, .yellow, .green]
       private var gridItems = [GridItem(.flexible()),
                                GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
        LazyVGrid(columns: gridItems, spacing: 5) {
                   ForEach((0...9), id: \.self) { index in
                       CellContent(index: index,
                              color: colors[index % colors.count])
                   }
               }
               .padding(5)
        }

    }
}

struct CreatorAllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorAllMoviesView()
    }
}
