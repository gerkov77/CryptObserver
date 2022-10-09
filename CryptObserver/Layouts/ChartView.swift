//
//  ChartView.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 09..
//

import SwiftUI

struct ChartView: View {

    @StateObject var viewModel: ChartViewModel = ChartViewModel()
    let currencyId: String

    var prices: [Double] {
        var prcs: [Double] = []
        viewModel.entries.forEach { entry in
            prcs.append(entry.priceUsdDouble)
        }
        return prcs
    }

    
    var labels: [String] {
        var lbls: [String] = []
        viewModel.entries.forEach { entry in
            lbls.append(entry.dateString)
        }
        return lbls
    }

    let chartWidth = UIScreen.main.bounds.width - 100
    private var path: Path {
        var path = Path()
        if prices.isEmpty {
              return path
            }
        var maxValue: CGFloat = 0
        var minValue: CGFloat = 0

        if let min = prices.min() {
            minValue = CGFloat(min)
        }
        if let max = prices.max() {
            maxValue = CGFloat(max)
        }

        let quotiens = 120/abs(maxValue-minValue)
        let firstPoint = (prices[0] - minValue)*quotiens

        var offsetX: Int = Int(chartWidth/CGFloat(prices.count))
        let padding: CGFloat = 20
        path.move(to: CGPoint(x: CGFloat(offsetX/2), y: firstPoint + padding))
        for price in prices {

                let offsetY = (price-minValue)*quotiens

                offsetX += Int(chartWidth/CGFloat(prices.count))
                path.addLine(to: CGPointMake(CGFloat(offsetX), CGFloat(offsetY + padding)))




        }
        return path
    }

    var body: some View {

        VStack {
            path.stroke(Color.white, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(height: 200)
        .onAppear {
            viewModel.fetchPriceChanges(fo: currencyId)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(currencyId: "bitcoin")
    }
}
