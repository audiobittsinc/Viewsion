//
//  Home2View.swift
//  Viewsion
//
//  Created by Denzil Dsa on 1/14/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct Home2View: View {
    @ObservedObject var homeVM: HomeViewModel = .init()
    
    init () {
        UITableView.appearance().backgroundColor = .clear
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color(.sRGB, red: 0, green: 0, blue: 85, opacity: 1.0))]
        homeVM.Get()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
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

#Preview {
    Home2View()
}
