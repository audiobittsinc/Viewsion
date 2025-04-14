//
//  MyMoviesView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct MyMoviesView: View {
    @ObservedObject private var viewModel = MyMoviesViewModel()
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                if(viewModel.myMovies.indices.isEmpty) {
                    Text("See a list of your uploaded movies here.")
                        .font(.largeTitle)
                        .padding()
                }
                List{
                    ForEach(viewModel.myMovies.indices, id:\.self) {index in
                        Text(viewModel.myMovies[index].title!)
                            .listRowBackground(Color.blue)
                        
                    }.onDelete(perform: { indexSet in
                        self.deleteRow(at: indexSet)
                    })
                }.navigationTitle("My Movies")
                    .onAppear {
                        viewModel.GetMyMovies()
                    }
                    .toolbar(content: {
                        NavigationLink(
                            destination: UploadMovieView(),
                            label: {
                                Image(systemName: "plus")
                            })
                    })
            }
        }
    }
    
    func deleteRow(at indexSet: IndexSet) {
        indexSet.sorted(by: > ).forEach { index in
            viewModel.Delete(movieId: viewModel.myMovies[index].id!)
        }
        viewModel.myMovies.remove(atOffsets: indexSet)
    }
}

struct MyMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MyMoviesView()
    }
}
