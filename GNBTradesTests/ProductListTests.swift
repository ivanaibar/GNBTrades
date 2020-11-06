//
//  ProductListTests.swift
//  ProductListTests
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import XCTest
import RxSwift
import RxTest
@testable import GNBTrades

final class ProductListTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    func testLoadingTransactionsFromAPIClient() {
        let viewModel = ProductListViewModel(apiClient: MockedTransactionsSuccessApi())
        let scheduler = TestScheduler(initialClock: 0)
        let reloadObserver = scheduler.createObserver(TableReload.self)
        viewModel.reloadFields.bind(to: reloadObserver).disposed(by: disposeBag)
        scheduler.scheduleAt(0, action: { viewModel.loadData() })
        scheduler.start()
        XCTAssertEqual(reloadObserver.events, [.next(0, .all)])
        XCTAssertEqual(viewModel.dataList.count, 1)
    }
    
    override func tearDown() {
        disposeBag = nil
    }

}

final class MockedTransactionsSuccessApi: ApiClient {
    func getData(of request: RequestBuilder, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let transaction = Transaction(sku: "ABCD", amount: "99.9", currency: "EUR")
        let response = Transactions(repeating: transaction, count: 50)
        
        completion(.success(try! JSONEncoder().encode(response)))
    }
}
