//
//  ProfileView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct CreatorsView: View {
    @ObservedObject var creatorVM = CreatorsViewModel()
    
    init() {
        creatorVM.Get()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                ScrollView {
                    if(creatorVM.creators.isEmpty) {
                        Text("Check out this compilation of video highlights from our Creator community.")
                            .font(.largeTitle)
                            .padding()
                    } else {
                        ForEach(creatorVM.creators, id:\.self) { creator in
                            CreatorRow(creator: creator)
                        }
                    }
                }
                .navigationTitle("Creators")
                .onAppear() {
                    creatorVM.Get()
                }
            }
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorsView()
    }
}

struct CreatorRow: View {
    @State var creator: Creator
    @State var showModalView = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showModalView.toggle()
            }, label: {
                ProfileStack(creator: creator)
            })
            ReactedMoviesStack(creator: creator)
            HighlightMoviesStack(creator: creator)
        }.padding()
    }
}

struct ProfileStack: View {
    var creator: Creator = Creator()
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    if(creator.profile != nil) {
                        if (creator.profile!.profileImageUrl == nil) {
                            Image(uiImage: UIImage(systemName: "person.crop.circle")!)
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75, alignment: .leading)
                                .offset(x: 10)
                            Text(creator.profile!.displayName ?? "Display Name")
                                .font(.title3)
                                .foregroundColor(.black)
                                .offset(x: -15)
                        } else {
                            AsyncImage(url: URL(string: (creator.profile!.profileImageUrl)!)!, placeholder: {Text("Loading...")}, image: { Image(uiImage: $0).resizable() })
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75, alignment: .leading)
                                .offset(x: 5)
                            Text(creator.profile!.displayName ?? "Display Name")
                                .font(.title3)
                                .foregroundColor(.black)
                                .offset(x: -15)
                        }
                        Spacer()
                    }
                }.frame(width: UIScreen.screenWidth, alignment: .leading)
            }
        }
    }
}

struct ReactedMoviesStack: View {
    var creator: Creator
    @ObservedObject var viewModel = CreatorsViewModel()
    @State var isPlayerPresented: Bool = false
    var body: some View {
        Group {
            // Category Row for Reacted Movies with HScroll
            if(creator.reactedMovies != nil && creator.reactedMovies!.count > 0) {
                HStack {
                    Text("Reacted Movies")
                        .font(.bold(.title3)())
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(
                        destination: AboutView(),
                        label: {
                            Text("All Movies")
                                .font(.body)
                                .foregroundColor(.black)
                                .offset(x: -5)
                        })
                    
                }.frame(width: UIScreen.screenWidth, alignment: .leading)
                ScrollView(.horizontal) {
                    HStack {
                        Spacer(minLength: 5)
                        if(creator.reactedMovies!.count >= 1 && creator.reactedMovies![1].originalUrl != nil) {
                            ForEach(creator.reactedMovies!.indices, id:\.self) { index in
                                VStack {
                                    Button(
                                        action: {
                                            viewModel.movie = creator.reactedMovies![index]
                                            viewModel.video = viewModel.LoadMovieIntoVideoForPlayer(key: 0, movie: viewModel.movie)
                                            isPlayerPresented.toggle()
                                        },
                                        label: {
                                            Spacer(minLength: 3)
                                            ReactedMovie(viewModel: ReactedMovieViewModel(m: creator.reactedMovies![index]))
                                        })
                                    HStack {
                                        Text(creator.reactedMovies![index].title!)
                                            .padding(10)
                                    }
                                }
                            }
                        }
                    }
                }.fullScreenCover(isPresented: $isPlayerPresented, content: {
                    PlayerView(data: [viewModel.video!])
                })
            }
        }
    }
}

struct HighlightMoviesStack: View {
    var creator: Creator
    @ObservedObject var viewModel = CreatorsViewModel()
    @State var isPlayerPresented: Bool = false
    var body: some View {
        Group {
            // List of Highlights
            VStack {
                if (creator.highlightMovie != nil){
                    if (creator.highlightMovie!.originalUrl != nil){
                        HStack {
                            Text("Highlights")
                                .padding()
                                .font(.bold(.title3)())
                                .foregroundColor(.black)
                                .offset(x: -5)
                            Spacer()
                            NavigationLink(
                                destination: AboutView(),
                                label: {
                                    Text("View All")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .offset(x: -5)
                                })
                        }.frame(width: UIScreen.screenWidth, alignment: .leading)
                        HStack {
                            Button(
                                action: {
                                    viewModel.movie = creator.highlightMovie!
                                    viewModel.video = viewModel.LoadMovieIntoVideoForPlayer(key: 0, movie: viewModel.movie)
                                    isPlayerPresented.toggle()
                                },
                                label:{
                                    Spacer(minLength: 7)
                                    HighlightMovie(viewModel: HighlightMovieViewModel(m: creator.highlightMovie!))
                                    Spacer()
                                })
                        }.frame(width: UIScreen.screenWidth, alignment: .center)
                        HStack {
                            Text((creator.highlightMovie!.title ?? ""))
                                .foregroundColor(.black)
                                .offset(x: 5)
                            Spacer()
                            Text((creator.highlightMovie!.description)!)
                                .foregroundColor(.black)
                                .offset(x: -5)
                        }.frame(width: UIScreen.screenWidth, alignment: .center)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isPlayerPresented, content: {
            PlayerView(data: [viewModel.video!])
        })
    }
}

struct ReactedMovie: View {
    @ObservedObject var viewModel: ReactedMovieViewModel
    
    var body: some View {
        Image(uiImage: viewModel.image ?? UIImage(named: "movie_placeholder")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 160, height: 250, alignment: .center)
            .cornerRadius(10.0)
    }
}

struct HighlightMovie: View {
    @ObservedObject var viewModel: HighlightMovieViewModel
    
    var body: some View {
        Image(uiImage: viewModel.image ?? UIImage(named: "movie_placeholder")!)
            .resizable()
            .frame(width: UIScreen.screenWidth, height: 300, alignment: .center)
    }
}
