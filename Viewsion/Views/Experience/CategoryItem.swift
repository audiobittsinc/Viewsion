//
//  CategoryItem.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    var video: Video
    
    var body: some View {
        VStack(alignment: .leading) {
            video.image
                .resizable()
                .frame(width: 220, height: 155)
                .cornerRadius(5)
            Text(video.title)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(video: ModelData().videos[0])
    }
}
