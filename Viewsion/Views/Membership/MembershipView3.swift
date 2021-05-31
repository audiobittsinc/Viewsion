//
//  MembershipView3.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/1/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

// 1. User photo circled
// 2. Name
// 3. Bio
// 4. Contact details
// 5. Send email button

import SwiftUI

struct MembershipView3: View {
    var body: some View {
        VStack {
            
            CircleImage(image: Image("harrypotter"))
                .offset(y: -130)
                .padding(.bottom, -130)
            UserName(name: "Harry Potter")
                .offset(y: 0)
            UserEmailBtn()
                .offset(y: 10)
            UserContacts(email: "harrypotter@gmail.com", website: "movieexample.com", twitter: "@harrypotter")
                .offset(y: 10)
            UserBio(bio: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae.")
                .frame(width: 350, height: 350, alignment: .top)
                .offset(y: 0)
        }
    }
}

struct MembershipView3_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView3()
    }
}
