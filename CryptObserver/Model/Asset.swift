//
//  Asset.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import Foundation

struct Asset: Codable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let priceUsd: String
    let changePercent24Hr: String?
}
