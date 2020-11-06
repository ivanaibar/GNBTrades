//
//  ProductTransactionsViewModel.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import Foundation
import RxSwift
import RxCocoa

struct Currency {
    static let Eur = "EUR"
}

protocol ProductTransactionsViewModelType {
    var transactions: Transactions { get }
    var totalAmount: Decimal? { get }
    var error: PublishSubject<String> { get }
    var updateTotalAmount: PublishSubject<Bool> { get }
    var showLoading: BehaviorRelay<Bool> { get }
    func loadData()
}

final class ProductTransactionsViewModel: ProductTransactionsViewModelType {

    let error = PublishSubject<String>()
    let updateTotalAmount = PublishSubject<Bool>()
    let showLoading = BehaviorRelay<Bool>(value: true)
    private let disposeBag = DisposeBag()
    private let apiClient: ApiClient
    var transactions: Transactions
    var ratesList: Rates = []
    var totalAmount: Decimal?
    
    init(apiClient: ApiClient = HTTPClient(), transactions: Transactions) {
        self.apiClient = apiClient
        self.transactions = transactions
    }
    
    func loadData() {
        showLoading.accept(true)
        let apiEndpoint = ProductTransactionsApi.getRates
        apiClient.getData(of: apiEndpoint) { [weak self] result in
            switch result {
            case let .success(data):
                let response: Rates? = data.parse()
                self?.ratesList.append(contentsOf: response ?? [])
                self?.totalAmount = self?.calculateTotalAmount()
                self?.updateTotalAmount.onNext(true)
                self?.showLoading.accept(false)
            case let .failure(error):
                self?.showLoading.accept(false)
                self?.error.onNext(error.localizedDescription)
            }
        }
    }
}

private extension ProductTransactionsViewModel {
    
    func calculateTotalAmount() -> Decimal? {
        var totalAmount: Decimal = 0.0
        
        for transaction in transactions {
            if transaction.currency == Currency.Eur {
                totalAmount += transaction.amountValue
            }else {
                if let rateSelected = ratesList.first(where: {$0.from == transaction.currency && $0.to == Currency.Eur}) {
                    
                    totalAmount += transaction.amountValue * rateSelected.rateValue
                }else {
                    var rates = ratesList
                    var conversionArray: Rates = []

                    let conversionLastStep = ratesList.first(where: { $0.to == Currency.Eur })
                    conversionArray.append(conversionLastStep!)
                    
                    rates = filterRates(rates: rates, conversion: conversionLastStep!)
                    
                    repeat {
                        if let conversionStep = rates.first(where: { $0.to == conversionArray.last!.from}) {
                            rates = filterRates(rates: rates, conversion: conversionStep)
                            
                            conversionArray.append(conversionStep)
                        }
                    } while (conversionArray.last!.from != transaction.currency)
                    
                    var conversionMultiplier: Decimal = 1
                    for conversion in conversionArray {
                        conversionMultiplier *= conversion.rateValue
                    }
                    
                    totalAmount += transaction.amountValue * conversionMultiplier
                    
                }
            }
        }
        
        return totalAmount.rounded(2, .bankers)
    }
    
    private func filterRates(rates: Rates, conversion: Rate) -> Rates {
        return rates.filter { ($0.from != conversion.from || $0.to != conversion.to) && ($0.from != conversion.to || $0.to != conversion.from)
        }
    }
}
