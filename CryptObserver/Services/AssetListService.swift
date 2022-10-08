//
//  AssetListService.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import Foundation


protocol AssetsListServiceProtocol: AssetsPublisher {
    var assets: [Asset] { get set }
    func fetchAssetsList() async throws
}


class AssetListService: AssetsPublisher,
                        AssetsListServiceProtocol,
                        ObservableObject {

    enum ServiceError: Error {
        case apiError(APIManager.ApiError)
    }

    private(set) var manager: APIManager = APIManager.shared

    func fetchAssetsList() async throws {
        do {
            let res =  try await manager
                .fetchItem(endpoint: .getAssets(), requestedType: AssetsData.self)
             res.data.forEach {  asset in
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    self?.assets.append(asset)
                }
            }
             } catch let error as APIManager.ApiError {
            throw ServiceError.apiError(error)
        }
    }
}

class AssetsPublisher {
    @Published var assets: [Asset] = []
}
