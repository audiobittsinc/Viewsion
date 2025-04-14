//
//  CategoryItem.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import AVKit

struct CategoryItem: View {
    @ObservedObject var categoryItemVM: CategoryItemViewModel
    
    var body: some View {
        VStack {
            Group {
                VStack(alignment: .leading) {
                    if (categoryItemVM.movie.originalUrl != nil) {
                        Image(uiImage: categoryItemVM.image ?? UIImage(named: "movie_placeholder")!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width:270, height: 180, alignment: .center)
                            .cornerRadius(8)
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 10.0)
                        Text(categoryItemVM.movie.title!)
                            .foregroundColor(.primary)
                            .font(.body)
                            .listRowBackground(Color(.sRGB, red: 0, green: 1, blue: 1, opacity: 0.5))
                            .padding(.bottom, 25)
                    }
                }
                .padding(.leading, 15)
            }
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static let categoryItem = CategoryItemViewModel(movieParam: Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat", description: "Sitting by the window", genre: "N/A", category: "Monologue", keywords: ["Story"], originalUrl: ""))
    
    static var previews: some View {
        CategoryItem(categoryItemVM: categoryItem)
    }
}
