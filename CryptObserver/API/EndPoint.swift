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
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
}

 extension Endpoint {
    static func getAssets(
      ) -> Endpoint {
            return Endpoint(
                path: "/v2/assets",
                queryItems: [])
        }
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
    var method: Endpoint.Method {
        switch self {
        default:
            return .GET
        }
    }
}

