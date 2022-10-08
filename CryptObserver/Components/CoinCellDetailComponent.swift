//
//  CoinCellDetailComponent.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct CoinCellDetailComponent: View {

    let price: String
    let changePercentage: String
    let priceChange: PriceChange

    var body: some View {
        VStack {

            Text("$\(price)")
                .bold()

            HStack {
                Image(systemName: priceChange.imageString)
                    .foregroundColor(priceChange.color)

                Text("\(changePercentage)%")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(priceChange.color)
                    .foregroundColor(.white)
                    .bold()
                    .cornerRadius(10)

            }
        }
        .padding(.trailing, 4)
    }
}

struct CoinCellDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        CoinCellDetailComponent(price: "21341234.2",
                                changePercentage: "3.5354",
                                priceChange: .increase)
    }
}
