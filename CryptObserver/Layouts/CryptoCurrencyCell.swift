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
    let priceDropped: Bool

    @Binding var isExpanded: Bool

    

    var body: some View {
        HStack {
            CoinCellProfileView(name: name,
                                symbol: symbol,
                                image: image)

            Spacer()

            CoinCellDetailView(price: price, changePercentage: changePercentage, priceDropped: priceDropped)
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
                           priceDropped: false,
                           isExpanded: .constant(false))
    }
}

struct CoinCellProfileView: View {

    let name: String
    let symbol: String
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: image)) { asyncImage in
            asyncImage.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 50, height: 50)
        .padding(.leading)
        VStack (alignment: .leading){
            Text(name)
            Text(symbol)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}

struct CoinCellDetailView: View {

    let price: String
    let changePercentage: String
    let priceDropped: Bool

    var body: some View {
        VStack {

            Text(price)

            HStack {
                Image(systemName: priceDropped ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .foregroundColor(priceDropped ? .red : .green)

                Text(changePercentage)
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
