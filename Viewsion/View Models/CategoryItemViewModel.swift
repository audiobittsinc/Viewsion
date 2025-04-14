//
//  CategoryItemViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 9/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

class CategoryItemViewModel: ObservableObject {
    @Published var movie: Movie = Movie()
    @Published var image: UIImage?
    
    init(movieParam: Movie) {
        self.movie = movieParam        
        getThumbnailImageFromVideoUrlAsync(url: URL(string: movieParam.originalUrl!)!) { image in
            self.image = image
        }
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    func getThumbnailImageFromVideoUrlAsync(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let time = CMTimeMakeWithSeconds(1, preferredTimescale: 60)
            let times = [NSValue(time: time)]
            
            avAssetImageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: {  _, image, _, _, error in
                if let image = image {
                    let uiImage = UIImage(cgImage: image)
                    DispatchQueue.main.async { //8
                        completion(uiImage) //9
                    }
                } else {
                    print("Thumbnail error: " + error!.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil) //11
                    }
                }
            })
        }
    }
}

