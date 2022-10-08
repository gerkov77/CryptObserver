//
//  AssetViewModel.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import Foundation

struct AssetViewModel {
    let id: String
    let name: String
    let symbol: String
    let price: String
    let changePercent24Hr: String
    var imageUrlString: String {
        return "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png"
    }

    var didDropPrice: Bool {

            if let percentage = Double(changePercent24Hr) {
                if percentage < 0 {
                    return true
                } else {
                    return false
                }
            }

    return false
    }

    var priceChange: PriceChange {
        if let change = Double(changePercentString) {
            switch change {
            case 0.0:
                return .neutral
            case ..<0.0:
                return .decrease
            default:
                return .increase
            }
        }
        return .neutral
    }

    var changePercentString: String {
        if let number = Double(changePercent24Hr) {
            return String(format: "%.1f", number )
        }
        return "0.00"
    }

    var priceString: String {
        if let number = Double(price) {
            return String(format: "%.4f", number)
        }
        return "0.0000"
    }
}

