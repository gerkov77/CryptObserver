//
//  EndPoint.swift
//  GKApiKit
//
//  Created by Gergely Kovacs on 2022. 09. 29..
//

import Foundation



 struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

 extension Endpoint {
    var url: URL? {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.coincap.io"
            components.path = path
            components.queryItems = queryItems
            return components.url
        }
    }
}

extension Endpoint {
   static func getAssets(
     ) -> Endpoint {
           return Endpoint(
               path: "/v2/assets",
               queryItems: [
                   URLQueryItem(name: "offset", value: "1"),
                   URLQueryItem(name: "limit", value: "200")
               ])
       }
}


extension Endpoint {
    static func chartDataFor(currencyId: String, interval: ChartInterval
     ) -> Endpoint {
           return Endpoint(
               path: "/v2/assets/\(currencyId)/history",
               queryItems: [
                URLQueryItem(name: "interval", value: interval.rawValue),
               ])
       }
}

enum ChartInterval: String {
    case day = "d1"
    case halfDay = "h12"
    case hour = "h1"
    case twoHours = "h2"
    case minute = "m1"
    case fiveMinutes = "m5"

}
