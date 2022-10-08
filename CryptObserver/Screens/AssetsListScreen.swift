//
//  ListScreen.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct AssetsListScreen: View {

    @StateObject var viewModel: AssetsListViewModel



    var body: some View {
        NavigationView {
            Group {

                if viewModel.assets.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.assets, id: \.id) { asset in
                                CryptoCurrencyCell(
                                    name: asset.name,
                                    symbol: asset.symbol,
                                    image: asset.imageUrlString,
                                    price: asset.priceString,
                                    changePercentage: asset.changePercentString,
                                    priceDropped: asset.didDropPrice,
                                    isExpanded: .constant(false))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 4)
                                    .shadow(radius: 4)
                            }
                        }
                    }
                }
            }
            .background {
                Color(uiColor: .systemGray5)
        }
            .onAppear {
                viewModel.fetchAssets()
            }
            .fullScreenCover(isPresented: $viewModel.isShowingConnectionError) {
                ConectionErrorScreen(message: viewModel.errorBody)
                    .environmentObject(viewModel)
            }
            .searchable(text: $viewModel.searchText)
        }

    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListScreen(viewModel: AssetsListViewModel())
    }
}
