//
//  PriceChange.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

enum PriceChange {
    case decrease
    case increase
    case neutral

    var color: Color {
        switch self {
        case .decrease:
            return Color.red
        case .increase:
            return Color.green
        case .neutral:
            return Color.gray
        }
    }

    var imageString: String {
        switch self {
        case .decrease:
            return "arrowtriangle.down.fill"
        case .increase:
            return "arrowtriangle.up.fill"
        case .neutral:
            return "circle.fill"
        }
    }
}
