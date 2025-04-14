//
//  ProfilePersonView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 1/12/25.
//  Copyright © 2025 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct ProfilePersonView: View {
    var body: some View {
        VStack {
            
            //Picture Stack
            Group {
                    VStack {
                        HStack {
                            Circle()
                                .padding(.leading)
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color.blue)
                            
                            //Followers Count
                            Group {
                                HStack {
                                    VStack {
                                        Text("415,586")
                                        Text("Followers")
                                    }.padding(.leading, 50.0)
                                    VStack {
                                        Text("150")
                                        Text("Following")
                                    }.padding(.leading, 50.0)
                                }
                            }
                            
                            Spacer()
                        }
                        HStack {
                            Text("Denzil D'sa")
                                .padding(.leading, 25.0)
                            Spacer()
                        }
                        HStack {
                            Text("AudioBitts")
                                .padding(.leading, 25.0)
                            Spacer()
                        }
                        HStack {
                            Text("Founder & CEO")
                                .padding(.leading, 25.0)
                            Spacer()
                        }
                }
            }
            

                
            
            //Social Buttons
            Group {
                HStack {
                    Spacer()
                    
                    Rectangle()
                            .frame(width: 120, height: 30)
                            .cornerRadius(8)
                            .foregroundColor(Color.red)
                    Rectangle()
                        .frame(width: 120, height: 30)
                        .cornerRadius(8)
                        .foregroundColor(Color.green)
                    Rectangle()
                        .frame(width: 120, height: 30)
                        .cornerRadius(8)
                        .foregroundColor(Color.blue)
                    Spacer()
                }
                
            }
            
            //Social Posts Stream
            Group {
                VStack {
                    Text("Social Posts")
                        .font(.headline)
                    Spacer()
                    ScrollView {
                        ForEach(0..<10) { _ in
                            Rectangle()
                                .frame(height: 300)
                            Text("Hello, World!")
                        }
                    }
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    ProfilePersonView()
}
