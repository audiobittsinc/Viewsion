//
//  StripeAccount.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/28/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation

struct StripeAccount: Codable, Hashable, Identifiable {
    var id: String?
    var accountId: String?
    var defaultCurrency: String?
}
