//
//  UserBio.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/13/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import SwiftUI

struct UserBio: View {
    var bio: String
    
    var body: some View {
        Text(bio)
            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.secondary)
    }
}

struct UserBio_Previews: PreviewProvider {
    static var previews: some View {
        UserBio(bio: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.")
    }
}
