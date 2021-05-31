//
//  ExperienceView2.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. Fullscreen letterbox with video in the center in portrait
// 2. On-video buttons for play/pause, forward and reverse (5 second tap or continuous hold)
// 3. Swipe down to close, swipe left for next, swipe right for previous.
// 4. Name/title shows up on bottom on load and pause
// 5. Landscape view for fullscreen video
// 6. Close video pauses movie, previous and next starts video from the beginning

import SwiftUI

struct ExperienceView2: View {
    var body: some View {
        NavigationView {
        Text("Feed view on dashboard nav bar")
            .navigationTitle("Home")
        }
    }
}

struct ExperienceView2_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView2()
    }
}
