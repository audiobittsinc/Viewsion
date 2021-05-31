//
//  ButtonsView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/19/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ButtonsView: View {
    var body: some View {
        VStack {
            HStack {
                Button("Buy") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
                Button("Bid") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
            }
            HStack {
                Button("Search") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
                Button("Analytics") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
            }
            HStack {
                Button("Upload") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
                Button("Mint") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
                Button("Monetize") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
            }
            HStack {
                Button("Menu") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
            }
            HStack {
                Button("Watch Now") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
                Button("Add to Queue") {
                    
                }
                .padding()
                .background(Color(red: 0.4, green: 0.1, blue: 0.8))
                .clipShape(Capsule())
                .accentColor(.white)
                
            }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
