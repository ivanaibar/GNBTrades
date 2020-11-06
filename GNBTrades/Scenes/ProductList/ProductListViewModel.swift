//
//  ProductListViewModel.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import Foundation
import RxSwift
import RxCocoa

enum TableReload: Equatable {
    case all
    case insertItems([IndexPath])
}

protocol ProductListViewModelType {
    var dataList: Transactions { get }
    var error: PublishSubject<String> { get }
    var isDataLoading: PublishSubject<Bool> { get }
    var reloadFields: PublishSubject<TableReload> { get }
    func loadData()
    func getProductTransactions(productSku: String) -> Transactions
}

final class ProductListViewModel: ProductListViewModelType {
    
    let error = PublishSubject<String>()
    let isDataLoading = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    private let apiClient: ApiClient
    private var productList: Transactions = []
    
    private(set) var reloadFields = PublishSubject<TableReload>()
    
    init(apiClient: ApiClient = HTTPClient()) {
        self.apiClient = apiClient
    }
    
    var dataList: Transactions {
        productList.unique { $0.sku }
    }
    
    func loadData() {
        let apiEndpoint = ProductListApi.getProducts
        isDataLoading.onNext(true)
        apiClient.getData(of: apiEndpoint) { [weak self] result in
            switch result {
            case let .success(data):
                let response: Transactions? = data.parse()
                self?.updateUI(with: response ?? [])
            case let .failure(error):
                self?.error.onNext(error.localizedDescription)
                self?.isDataLoading.onNext(false)
            }
        }
    }
    
    func getProductTransactions(productSku: String) -> Transactions {
        return productList.filter { $0.sku == productSku }
    }
}

private extension ProductListViewModel {
    func updateUI(with products: Transactions) {
        isDataLoading.onNext(false)
        productList.append(contentsOf: products)
        reloadFields.onNext(.all)
    }
}
