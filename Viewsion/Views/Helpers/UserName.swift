//
//  UserName.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct UserName: View {
    var name: String
    
    var body: some View {
        Text(name)
            .fontWeight(.bold)
    }
}

struct UserName_Previews: PreviewProvider {
    static var previews: some View {
        UserName(name: "Harry")
    }
}
