//
//  ContentViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 4/29/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation


class ContentViewModel {
    @Published var title: String = ""
    @Published var synopsis: String = ""
    @Published var duration: String = ""
    @Published var video: Data = Data()
    
    init() {
        // fetchVideo()
    }
    
    func fetchVideo() {
        guard let url = URL(string: "") else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            do
            {
                let model = try JSONDecoder().decode(Video.self, from: data)
                
                DispatchQueue.main.async {
                    self.title = model.title
                    self.synopsis = model.synopsis
                    self.duration = model.duration
                    self.video = model.video
                }
            } catch {
                print("failed fetch")
            }
        })
        task.resume()
    }
}
