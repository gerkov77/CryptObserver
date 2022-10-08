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
    let image: String
    let changePercent24Hr: String?
    var imageUrlString: String {
        return "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png"
    }

    var didDropPrice: Bool {
        if let changed = changePercent24Hr {
            if let percentage = Double(changed) {
                if percentage < 0 {
                    return true
                } else {
                    return false
                }
            }
        }
    return false
    }

    var changePercentString: String {
        if let changedString = changePercent24Hr {
            let substring = changedString.dropLast(10)
            return String(substring)
        }
        return ""
    }

    var priceString: String {
        if let changedString = changePercent24Hr {
            let substring = changedString.dropLast(10)
            return String(substring)
        }
        return ""
    }
}

