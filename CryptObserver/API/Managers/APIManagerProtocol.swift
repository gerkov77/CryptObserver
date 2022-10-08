//
//  APIManagerProtocol.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import Foundation

protocol ApiManagerProtocol {
    func fetchItem<Item: Codable>(
        endpoint: Endpoint,
        requestedType: Item.Type) async throws -> Item
    func fetchItems<Item: Codable>(
        endpoint: Endpoint,
        requestedType: [Item.Type]) async throws -> [Item]
}
