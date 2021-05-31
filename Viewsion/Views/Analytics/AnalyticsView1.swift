//
//  AnalyticsView1.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct AnalyticsView1: View {
    @State private var selectedColorIndex = 0
        
        var body: some View {
            
            NavigationView {
            VStack {
                Picker("Favorite Color", selection: $selectedColorIndex, content: {
                    Text("Single Video").tag(0)
                    Text("All Videos").tag(1)
                    Text("Comparable Video").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                // <1>
                Text("Selected color: \(selectedColorIndex)")
                Spacer()
                if selectedColorIndex == 0 {
                    Group {
                    Color(.red)
                    Text("RED selection")
                    }
                }
                else if selectedColorIndex == 1 {
                    Group {
                    Color(.green)
                    Text("GREEN selection")
                    }
                }
                else if selectedColorIndex == 2 {
                    Group {
                    Color(.blue)
                    Text("BLUE selection")
                    }
                }
            }.navigationBarTitle("Analytics")
            }
        }
    }

struct AnalyticsView1_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView1()
    }
}
