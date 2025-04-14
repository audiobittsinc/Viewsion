//
//  PlayerViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var player: Player?
    @Published var index: Int = 0
    @Published var data: [Video] = []
    
    init(videoData: [Video]) {
        self.data = videoData
    }
    
    
}
