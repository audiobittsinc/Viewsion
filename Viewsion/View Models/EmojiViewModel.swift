//
//  EmojiViewModel.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

class EmojiViewModel: ObservableObject {
    @Published var emojis: [Emoji]?
    var service: EmojiService?
    
    init() {
        service = EmojiService()        
        GetEmojis()
    }
    
    func GetEmojis() {
        service?.Get() { result in
            switch result {
            case .success(let emojis):
                DispatchQueue.main.async { [self] in
                    self.emojis = emojis
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
