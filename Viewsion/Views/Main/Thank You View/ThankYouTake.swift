//
//  ThankYouTake.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/29/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ThankYouTake: View {
    @ObservedObject var viewModel: ThankYouTakeViewModel
    
    var body: some View {
        Image(uiImage: viewModel.image ?? UIImage(named: "movie_placeholder")!)
            .resizable()
            .cornerRadius(3.0)
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct ThankYouTake_Previews: PreviewProvider {
    static let vm = ThankYouTakeViewModel(m: Movie())
    
    static var previews: some View {
        ThankYouTake(viewModel: vm)
    }
}
