//
//  ReactionRow.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/30/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI

class ReactionRow: Codable, Hashable {
    static func == (lhs: ReactionRow, rhs: ReactionRow) -> Bool {
        return lhs.emoji == rhs.emoji && lhs.barWidth == rhs.barWidth && lhs.total == rhs.total
    }
    
    var emoji: String?
    var barWidth: CGFloat?
    var total: String?
    
    init(pEmoji: String, pBarWidth: CGFloat, pTotal: Int) {
        self.emoji = pEmoji
        self.barWidth = pBarWidth
        self.total = formatNumber(pTotal)
    }
    
    init() {
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
    }
    
}

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

func formatNumber(_ n: Int) -> String {
    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""
    
    switch num {
    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)B"
        
    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)M"
        
    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.reduceScale(to: 1)
        return "\(sign)\(formatted)K"
        
    case 0...:
        return "\(n)"
        
    default:
        return "\(sign)\(n)"
    }
}
