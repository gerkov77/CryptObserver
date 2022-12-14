//
//  CryptoCurrencyCell.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct CryptoCurrencyCell: View {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let price: String
    var changePercentage: String
    let priceChange: PriceChange
    var isExpanded: Bool

    var body: some View {
        VStack {
            HStack {
                CoinCellProfileComponent(name: name,
                                    symbol: symbol,
                                    image: image)

                Spacer()

                CoinCellDetailComponent(price: price,
                                        changePercentage: changePercentage,
                                        priceChange: priceChange)
                    .padding(.vertical, 4)

                Divider()

                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(Color(uiColor: .systemGray))
                    .padding()
            }
            .frame(height: 74)
            .background(Color.white)
        .cornerRadius(5)
            if isExpanded {

                Color(uiColor: .darkGray)
                    .frame(height: 200)
                    .overlay {
                        ChartView(currencyId: id)
                    }
            }
        }
    }
}

struct CryptoCurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyCell(id: "bitcoin",
                           name: "Bitcoin",
                           symbol: "BTC",
                           image: "bitcoinsign.circle",
                           price: "1231231.33",
                           changePercentage: "-0.23598",
                           priceChange: .increase,
                           isExpanded: false)
    }
}
