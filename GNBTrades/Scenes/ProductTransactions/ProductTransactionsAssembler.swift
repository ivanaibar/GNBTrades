//
//  ProductTransactionsAssembler.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import Foundation
import UIKit

extension Destination {
    func getProductTransactionsViewController(transactions: Transactions) -> UIViewController {
        return ProductTransactionsViewController(viewModel: ProductTransactionsViewModel(transactions: transactions))
    }
}
