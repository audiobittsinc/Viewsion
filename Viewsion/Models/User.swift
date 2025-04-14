//
//  User.swift
//  Viewsion
//
//  Created by Denzil Dsa on 5/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Codable, Hashable, Identifiable {
    var id: String?
    var username: String?
    var password: String?
    var email: String?
    var profile: Profile?
    var stripeAccount: StripeAccount?
    var jwtToken: String?
    var createdAt: Date?
    var updatedAt: Date?
}
