//
//  ThankYouView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ThankYouView: View {
    @ObservedObject var viewModel = ThankYouViewModel()
    private var maxHt = UIScreen.main.bounds.size.height
    @State var isPlayerPresented: Bool = false
    let data = (1...50).map { "Item \($0)" }
    let columns = [GridItem(.adaptive(minimum: 95))]
    
    init() {
        viewModel.Get()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                VStack {
                    Group {
                        ScrollView {
                            if(viewModel.thankYou.movies.indices.isEmpty) {
                                Text("Check out this compilation of thank you videos that show up here when you React to a movie (Coming Soon).")
                                    .font(.largeTitle)
                                    .padding()
                            }
                            LazyVGrid(columns: columns, spacing: 25) {
                                ForEach(viewModel.thankYou.movies.indices, id: \.self) { index in
                                    VStack {
                                        Button(action: {
                                            viewModel.movie = viewModel.thankYou.movies[index]
                                            viewModel.video = viewModel.LoadMovieIntoVideoForPlayer(key: index, movie: viewModel.movie)
                                            isPlayerPresented.toggle()
                                        }, label: {
                                            ThankYouTake(viewModel: ThankYouTakeViewModel(m: viewModel.thankYou.movies[index]))
                                        })
                                        Text(viewModel.thankYou.profiles[index].displayName ?? "")
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxHeight: 1000)
                    }
                }
                .fullScreenCover(isPresented: $isPlayerPresented, content: {
                    PlayerView(data: [viewModel.video!])
                })
                .navigationTitle("Thank You")
                .onAppear {
                    viewModel.Get()
                }
            }
        }
    }
}

struct ThankYouView_Previews: PreviewProvider {
    static let categoryItem = CategoryItemViewModel(movieParam: Movie(id: "001-ABC", creatorId: "456-ABC", title: "My Pet Cat", description: "Sitting by the window", genre: "N/A", category: "Monologue", keywords: ["Story"], originalUrl: ""))
    
    static var previews: some View {
        ThankYouView()
    }
}
