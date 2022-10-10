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
    let chartWidth = UIScreen.main.bounds.width - 100

    var body: some View {

        VStack {
            ZStack {
                HStack {
                    ForEach(0..<12) {_ in
                        Divider()
                            .overlay(Color(uiColor: .lightGray))
                        Spacer()
                    }
                }
                path.stroke(Color.white, lineWidth: 2.0)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
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

extension ChartView {

    fileprivate var path: Path {
        var path = Path()

        if viewModel.prices.isEmpty {
            return path
        }
        var maxValue: CGFloat = 0
        var minValue: CGFloat = 0

        if let min = viewModel.prices.min() {
            minValue = CGFloat(min)
        }

        if let max = viewModel.prices.max() {
            maxValue = CGFloat(max)
        }

        let quotiens = 120/abs(maxValue-minValue)
        let firstPoint = (viewModel.prices[0] - minValue)*quotiens
        var offsetX: Int = Int(chartWidth/CGFloat(viewModel.prices.count))
        let padding: CGFloat = 20

        path.move(to: CGPoint(x: CGFloat(offsetX), y: firstPoint + padding))

        for price in viewModel.prices.suffix(11) {
            let offsetY = (price-minValue)*quotiens
            offsetX += Int(chartWidth/CGFloat(viewModel.prices.count))
            path.addLine(to: CGPointMake(CGFloat(offsetX), CGFloat(offsetY + padding)))
        }
        return path
    }
}
