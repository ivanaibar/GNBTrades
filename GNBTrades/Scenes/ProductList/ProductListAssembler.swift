//
//  ProductListAssembler.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import Foundation
import UIKit

enum Destination {
    case productList
    case productTransactions(Transactions)
    
    var controller: UIViewController {
        switch self {
        case .productList:
            return getProductListViewControler()
        case let .productTransactions(transactions):
            return getProductTransactionsViewController(transactions: transactions)
        }
    }
}

extension Destination {
    func getProductListViewControler() -> UIViewController {
        return ProductListViewController(viewModel: ProductListViewModel())
    }
}
