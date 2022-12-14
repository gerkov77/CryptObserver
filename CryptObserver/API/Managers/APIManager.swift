//
//  APIManager.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import Foundation

actor APIManager: ApiManagerProtocol {

    static let shared = APIManager()
     private init() {}

    enum ApiError: Error {
        case invaludUrl
        case invalidData
        case unableToComplete
        case networkError(Error)

        var message: String {
            switch self {
            case .invaludUrl:
                return "There was a problem with the url"
            case .invalidData:
                return "There was a problem with the received data"
            case .unableToComplete:
                return "App was unable to complete the operation, check your internet connection"
            case .networkError(let err):
                return err.localizedDescription
            }
        }
    }
}

extension APIManager {
    func fetchItems<Item: Codable>(endpoint: Endpoint, requestedType: [Item.Type]) async throws -> [Item] {
        guard let url: URL =  endpoint.url else {
            throw ApiError.invaludUrl
        }
        var (data, response) = (Data(), URLResponse())

        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch let error {
            throw ApiError.networkError(error)
        }

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ApiError.unableToComplete
        }

        let decoder = JSONDecoder()

        let reposResult = try decoder.decode(Array<Item>.self, from: data)

        return reposResult
    }
}

extension APIManager {
    func fetchItem<Item: Codable>(endpoint: Endpoint, requestedType: Item.Type) async throws -> Item {
        guard let url: URL =  endpoint.url else {
            throw ApiError.invaludUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ApiError.unableToComplete
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(Item.self, from: data)

        return result
    }
}
