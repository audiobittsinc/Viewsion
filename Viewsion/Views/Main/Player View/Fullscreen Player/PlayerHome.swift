//
//  PlayerHome.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/10/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerHome : View {
    @ObservedObject var viewModel: PlayerViewModel
    @ObservedObject var contentModerationVM = ReportContentViewModel()
    @State var index = 0
    @State var top = 0
    @State var showModalView = false
    @State var signInRequired = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            PlayerScrollView(data: self.$viewModel.data, index: self.$viewModel.index)
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .accentColor(.white)
                    }).padding()
                    Spacer()
                    Menu {
                        Button {
                            if(vUsername == "") {
                                signInRequired.toggle()
                                return
                            }
                            contentModerationVM.reportedContent = ReportedContent(movieId: viewModel.data[viewModel.index].movie.id, username: vUsername, comment: "")
                            contentModerationVM.Create(contentReport: contentModerationVM.reportedContent!)
                        } label: {
                            Label("Report Content", systemImage: "exclamationmark.triangle")
                        }
                    } label: {
                        Image("3-dot-icon-0")
                            .resizable()
                            .frame(width: 60.0, height: 60.0)
                    }
                    .alert("Please Sign In", isPresented: $signInRequired) {
                        Button("OK", role: .cancel) { }
                    }
                    .alert("The content is reported.", isPresented: self.$contentModerationVM.contentReported) {
                        Button("OK", role: .cancel) { }
                    }
                }.offset(y: 50)
                
                
                Spacer()
                HStack(spacing: 0){
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

struct PlayerViw : View {
    
    @Binding var data : [Video]
    @State var showModalView = false
    @ObservedObject var reactionVM = ReactionsViewModel()
    @Binding var index: Int
    
    var body: some View {
        VStack(spacing: 0){
            ForEach(0..<self.data.count){i in
                ZStack{
                    Playa(player: self.data[i].player)
                    // full screensize because were going to make paging...
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -10)
                    VStack {
                        Spacer()
                        HStack(spacing: 15) {
                            // TODO REACTIONS
                            //                        Button(action: {
                            //
                            //                            //self.top = 1
                            //                            reactionVM.movieId = MovieId(userId: vUserId, movieId: self.data[i].movie.id!)
                            //                            //reactionVM.Get(movieId: reactionVM.movieId!)
                            //                            self.showModalView.toggle()
                            //
                            //                        }) {
                            //                            Image(systemName: "chevron.up.square")
                            //                                .resizable()
                            //                                //.renderingMode(.original)
                            //                                .accentColor(.white)
                            //                                .frame(width: 30, height: 30, alignment: .center)
                            //                                .padding(30)
                            //                        }
                        }
                    }
                    if self.data[i].replay{
                        Button(action: {
                            // playing the video again...
                            self.data[i].replay = false
                            self.data[i].player.seek(to: .zero)
                            self.data[i].player.play()
                            
                        }) {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            // doing it for first video because scrollview didnt dragged yet...
            self.data[0].player.play()
            self.data[0].player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { (_) in
                // notification to identify at the end of the video...
                // enabling replay button....
                //self.data[0].replay = true
            }
        }
        .sheet(isPresented: $showModalView, content: {
            ReactionsView(reactionsVM: reactionVM)
            //AboutView()
        })
    }
}

struct Playa : UIViewControllerRepresentable {
    
    var player : AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspect
        return view
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: ()) {
        uiViewController.player?.pause()
    }
}

class Host : UIHostingController<ContentView>{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


// sample video for video playing...

struct Video : Identifiable {
    var id : Int
    var player : AVPlayer
    var replay : Bool
    var movie : Movie
}

struct PlayerScrollView : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    @Binding var data : [Video]
    @Binding var index : Int
    
    func makeUIView(context: Context) -> UIScrollView{
        let view = UIScrollView()
        let childView = UIHostingController(rootView: PlayerViw(data: self.$data, index: self.$index))
        
        // each children occupies one full screen so height = count * height of screen...
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        // same here...
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        // to ignore safe area...
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // to dynamically update height based on data...
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        for i in 0..<uiView.subviews.count{
            uiView.subviews[i].frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        }
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        var parent : PlayerScrollView
        var index = 0
        init(parent1 : PlayerScrollView) {
            parent = parent1
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currenrindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currenrindex{
                index = currenrindex
                
                // Pass the index to parent view
                parent.index = index
                
                for i in 0..<parent.data.count{
                    // pausing all other videos...
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                    
                }
                // playing next video...
                parent.data[index].player.play()
                parent.data[index].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { (_) in
                    // notification to identify at the end of the video...
                    // enabling replay button....
                    //self.parent.data[self.index].replay = true
                }
            }
        }
    }
    
    struct PlayerHome_Previews: PreviewProvider {
        static let data = [
            Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video1", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1")),
            Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video2", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1")),
            Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video3", ofType: "mp4")!)), replay: false, movie: Movie(id: "001-ABC", creatorId: "456-ABC", title: "Interstellar", description: "A movie by christopher nolan", genre: "N/A", category: "Documentry", keywords: ["Story"], originalUrl: "video1"))
        ]
        
        static var previews: some View {
            PlayerHome(viewModel: PlayerViewModel(videoData: data))
        }
    }
}

