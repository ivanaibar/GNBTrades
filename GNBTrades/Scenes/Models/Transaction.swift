//
//  Product.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import Foundation

// MARK: - Transaction
struct Transaction: Codable, Equatable, Hashable {
    let sku: String
    let amount: String
    let currency: String
    
    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.sku == rhs.sku
    }
}

extension Transaction {
    var amountValue: Decimal {
        return amount.toDecimalWithAutoLocale() ?? 0
    }
}

typealias Transactions = [Transaction]

