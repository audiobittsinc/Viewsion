//
//  HomeView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel = HomeViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color(.sRGB, red: 0, green: 0, blue: 85, opacity: 1.0))]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color(.sRGB, red: 0, green: 0, blue: 85, opacity: 1.0))]
        homeVM.Get()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                VStack {
                    Group {
                        if (homeVM.categories != nil) {
                            List(homeVM.categories!.keys.sorted(), id:\.self) { key in
                                CategoryRow(categoryRowVM: CategoryRowViewModel(category: key, items: homeVM.categories![key]!))
                                    .listRowBackground(Color.blue)
                            }
                            .listStyle(GroupedListStyle())
                            .refreshable {
                                homeVM.Get()
                            }
                        } else {
                            //Catch network issues error here
                        }
                    }
                }.navigationBarTitle("MovieSource", displayMode: .automatic)
                    .frame(width: UIScreen.screenWidth, alignment: .leading)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

