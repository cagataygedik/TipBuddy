//
//  TipEnum.swift
//  TipBuddy
//
//  Created by Celil Çağatay Gedik on 29.12.2023.
//

import Foundation

enum TipEnum {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case customTip(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .customTip(let value):
            return String(value)
        }
    }
}
