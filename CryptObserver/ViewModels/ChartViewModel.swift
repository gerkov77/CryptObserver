//
//  ChartViewModel.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 09..
//

import Combine
import Foundation

class ChartViewModel: ObservableObject {
    private(set) var service: ChartService = ChartService()

    @Published var entries: [ChartDataViewModel] = []

    var prices: [Double] {
        var prcs: [Double] = []
        entries.forEach { entry in
            prcs.append(entry.priceUsdDouble)
        }
        return prcs
    }


    var labels: [String] {
        var lbls: [String] = []
        entries.forEach { entry in
            lbls.append(entry.dateString)
        }
        return lbls
    }

    var bag = Set<AnyCancellable>()


    func fetchPriceChanges(fo id: String) {
        Task {
            do {
                 try await service.fetchChartDate(for: id, interval: .twoHours)

                    service.$chartData
                        .receive(on: RunLoop.main)
                        .sink { [weak self] value in
                            self?.entries = value.suffix(12).map({ entry in
                                print(entry)
                                return ChartDataViewModel(priceUsd: entry.priceUsd, time: entry.time)
                            })
                    }
                        .store(in: &bag)

            } catch let err {
                print(">> vm fetch error: \(err.localizedDescription)")
            }
        }
    }
}

struct ChartDataViewModel: Identifiable {
    let id: String = UUID().uuidString
    let priceUsd: String
    let time: Int

    var priceUsdDouble: Double {
        if let double = Double(priceUsd) {
            return double
        }
        return 0.0
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.calendar = Calendar.current

        let date = Date(timeIntervalSince1970: TimeInterval(time))

        return formatter.string(from: date)
    }
}
