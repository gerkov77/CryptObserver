//
//  ChartService.swift
//  CryptObserver
//
//  Created by Gergely Kovacs on 2022. 10. 09..
//

import Combine
import Foundation

class ChartService: ObservableObject {
    private(set) var manager: ApiManagerProtocol = APIManager.shared

    @Published var chartData: [PriceChartEntry] = []

    func fetchChartDate(for id: String, interval: ChartInterval) async throws {
        do {
            let res: ChartData = try await manager.fetchItem(endpoint: .chartDataFor(currencyId: id, interval: interval), requestedType: ChartData.self)
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.chartData.append(contentsOf: res.data)
            }

        } catch let error as APIManager.ApiError {
            print(">> api error \(error.localizedDescription)")
        }

    }
}
