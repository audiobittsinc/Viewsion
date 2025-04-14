//
//  AboutView.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/26/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                ScrollView {
                    Image("default")
                        .resizable()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth, alignment: .center)
                    VStack {
                        Spacer()
                        Text("We are MovieSource. We produce the finest movies and videos on the internet. We have the best content available made with the highest premium quality that our vibrant users demand and deserve. We give the most attention to our creator community and seek to create the finest products and services for the movie industry.").multilineTextAlignment(.center)
                            .font(.callout).padding()
                        Spacer(minLength: 5.0)
                        Group {
                            Text("MovieSource Inc.").font(.caption)
                            Text("145 Talmadge Rd #9, Edison, NJ 08817 USA").font(.caption)
                            Text("+1 (732) 917 0799").font(.caption)
                        }.foregroundColor(Color.secondary)
                        Spacer(minLength: 5.0)
                        Link("Read our privacy policy", destination: URL(string: "https://moviesource-devteam-v01.azurewebsites.net/staticfiles/privacypolicy.html")!).font(.caption).foregroundColor(Color.secondary)
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle("About Us")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
