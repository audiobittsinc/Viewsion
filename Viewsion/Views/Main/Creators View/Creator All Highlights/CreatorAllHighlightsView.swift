//
//  CreatorAllHighlightsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/2/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CreatorAllHighlightsView: View {
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

struct CellContent: View {
        var index: Int
        var color: Color
    
        var body: some View {
            Text("\(index)")
                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 250)
                .background(color)
                .cornerRadius(8)
                .font(.system(.largeTitle))
        }
    }

struct CreatorAllHighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorAllHighlightsView()
    }
}
