//
//  CryptoCurrencyCell.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct CryptoCurrencyCell: View {

    let name: String
    let symbol: String
    let image: String
    let price: String
    var changePercentage: String
    let priceChange: PriceChange

    @Binding var isExpanded: Bool

    

    var body: some View {
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
    }
}

struct CryptoCurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyCell(name: "Bitcoin",
                           symbol: "BTC",
                           image: "bitcoinsign.circle",
                           price: "1231231.33",
                           changePercentage: "-0.23598",
                           priceChange: .increase,
                           isExpanded: .constant(false))
    }
}
