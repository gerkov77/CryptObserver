//
//  AssetsListViewModel.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//
import Foundation
import Combine

class AssetsListViewModel: ObservableObject {
    private(set) var service: AssetsListServiceProtocol = AssetListService()

    @Published var assets: [AssetViewModel] = []
    @Published var errorTitle: String = ""
    @Published var errorBody: String = ""
    @Published var isShowingError: Bool = false
    @Published var isShowingConnectionError: Bool = false
    @Published var searchText: String = ""

    var bag = Set<AnyCancellable>()

    func fetchAssets() {
        Task {
            do {
                try await service.fetchAssetsList()
            } catch AssetListService.ServiceError.apiError(let error) {
                await MainActor.run {
                    errorBody = error.message
                    switch error {
                    case .unableToComplete:
                        errorTitle = "Connetction error"
                        isShowingError = true
                    case .invaludUrl:
                        errorTitle = "Invalid Url"
                        isShowingError = true
                    case .invalidData:
                        errorTitle = "Invalid data"
                        isShowingError = true
                    case .networkError:
                        errorTitle = "Network error"
                        isShowingError = true
                    }
                }

            } catch let error {
                await MainActor.run {
                    errorTitle = "Connection Error"
                    print(error.localizedDescription)
                    errorBody = error.localizedDescription
                    isShowingConnectionError = true
                }
            }
        }
        
        service.$assets
            .receive(on: RunLoop.main)
            .sink { [weak self] assets in

                self?.assets = assets.map { asset in
                    return AssetViewModel(id: asset.id,
                                          name: asset.name,
                                          symbol: asset.symbol,
                                          price: asset.priceUsd,
                                          changePercent24Hr: asset.changePercent24Hr
                    )
                }
            }
            .store(in: &bag)
        filterAssets()
    }
    private func filterAssets() {
        let searchTextFilteredAssetsPublisher: AnyPublisher<[Asset], Never> = $searchText
            .combineLatest(service.$assets)
            .receive(on: DispatchQueue.main)
            .map { (text, assets) -> [Asset] in
                guard !text.isEmpty else { return assets}
                let lowerText = text.lowercased()
                let filteredAssets = assets.filter {
                    return $0.name.lowercased().contains(lowerText) ||
                    $0.symbol.lowercased().contains(lowerText)
                }
                print(">> filtered assets : \(filteredAssets)")
                return filteredAssets
            }
            .eraseToAnyPublisher()

        searchTextFilteredAssetsPublisher
            .sink { [weak self] assets in
                guard let self = self else { return }
               let assetVms = assets.map {
                    asset in
                   return AssetViewModel(id: asset.id,
                                         name: asset.name,
                                         symbol: asset.symbol,
                                         price: asset.priceUsd,
                                         changePercent24Hr: asset.changePercent24Hr)

                }
                self.assets = assetVms
        }
            .store(in: &bag)
    }
}
