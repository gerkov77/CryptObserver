//
//  ChartData.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 09..
//

import Foundation

struct ChartData: Codable {
    let data: [PriceChartEntry]
}

struct PriceChartEntry: Codable {
    let priceUsd: String
    let time: Int
}
