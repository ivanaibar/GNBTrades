//
//  Rate.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import Foundation

// MARK: - Rate
struct Rate: Codable {
    let from: String
    let to: String
    let rate: String
}

extension Rate {
    var rateValue: Decimal {
        return rate.toDecimalWithAutoLocale() ?? 0
    }
}

typealias Rates = [Rate]
