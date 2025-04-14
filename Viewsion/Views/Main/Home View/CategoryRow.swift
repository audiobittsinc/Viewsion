//
//  CategoryRow.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    @ObservedObject var categoryRowVM: CategoryRowViewModel
    @State var isPlayerPresented: Bool = false
    
    var body: some View {
        VStack {
            Group {
                VStack(alignment: .leading) {
                    Text(categoryRowVM.categoryName!)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                        .padding(.bottom, 30)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categoryRowVM.items!.indices, id:\.self) { index in
                                Button(action: {
                                    categoryRowVM.movieItems = categoryRowVM.items!
                                    categoryRowVM.movieData = categoryRowVM.LoadMoviesIntoVideoForPlayer(key: index, movies: categoryRowVM.items!)
                                    
                                    isPlayerPresented.toggle()
                                }, label: {
                                    CategoryItem(categoryItemVM: CategoryItemViewModel(movieParam: categoryRowVM.items![index]))
                                })
                            }
                        }
                    }
                    .frame(height: 185)
                }
            }
        }.fullScreenCover(isPresented: $isPlayerPresented, content: {
            PlayerView(data: categoryRowVM.movieData!)
        })
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static let rowVM = CategoryRowViewModel(category: "Monologue", items: [Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat", description: "Sitting by the window", genre: "N/A", category: "Monologue", keywords: ["Story"], originalUrl: ""), Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat", description: "Sitting by the window", genre: "N/A", category: "Monologue", keywords: ["Story"], originalUrl: "")])
    
    static var previews: some View {
        CategoryRow(categoryRowVM: rowVM)
    }
}
