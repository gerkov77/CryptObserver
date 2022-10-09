//
//  ChartView.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 09..
//

import SwiftUI

struct ChartView: View {

    let prices = [1.1, 2.2, 3.4, 5, 6.0, 0.8, -2.0]

    let labels: [String] = ["2000", "2001", "2002", "2003", "2004"]
    let chartWidth = UIScreen.main.bounds.width - 100
    private var path: Path {
        var path = Path()
        if prices.isEmpty {
              return path
            }
        var offsetX: Int = Int(chartWidth/CGFloat(prices.count))
        path.move(to: CGPoint(x: CGFloat(offsetX), y: CGFloat(prices[0])))

        for price in prices {

            offsetX += Int(chartWidth/CGFloat(prices.count))
            path.addLine(to: CGPointMake(CGFloat(offsetX), CGFloat(price*10)))
        }
        return path
    }

    var body: some View {

        VStack {
            
            path.stroke(Color.red, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center)

            HStack {
                ForEach(labels, id: \.self) { label in
                    Text(label)
                        .frame(width: chartWidth/CGFloat(label.count) - 10)
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                }
            }
        }
        .frame(height: 200)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
