//
//  CoinCellProfileComponent.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//

import SwiftUI

struct CoinCellProfileComponent: View {

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

struct CoinCellProfileComponent_Previews: PreviewProvider {
    static var previews: some View {
        CoinCellProfileComponent(name: "Bitcoin", symbol: "btc", image: "")
    }
}
