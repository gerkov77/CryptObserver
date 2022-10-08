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
    let priceDropped: Bool

    var body: some View {
        VStack {

            Text("$\(price)")

            HStack {
                Image(systemName: priceDropped ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .foregroundColor(priceDropped ? .red : .green)

                Text("\(changePercentage)%")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(priceDropped ? .red : .green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }
        }
        .padding(.trailing, 4)
    }
}

struct CoinCellDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        CoinCellDetailComponent(price: "21341234.2", changePercentage: "3.5354", priceDropped: false)
    }
}
