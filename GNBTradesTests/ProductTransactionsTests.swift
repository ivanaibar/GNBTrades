//
//  ProductTransactionsTests.swift
//  GNBTradesTests
//
//  Created by Ivan Aibar Romero on 06/11/2020.
//

import XCTest
import RxSwift
import RxTest
@testable import GNBTrades

final class ProductTransactionsTests: XCTestCase {
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        
    }
    
    func testLoadingRatesFromAPIClient() {
        let transaction = Transaction(sku: "ABCD", amount: "10", currency: "USD")
        let viewModel = ProductTransactionsViewModel(apiClient: MockedRatesSuccessApi(), transactions: [transaction])
        let scheduler = TestScheduler(initialClock: 0)
        scheduler.scheduleAt(0, action: { viewModel.loadData() })
        scheduler.start()
        XCTAssertEqual(viewModel.ratesList.count, 6)
        XCTAssertEqual(viewModel.totalAmount, 20)
    }
    
    override func tearDown() {
        disposeBag = nil
    }

}

final class MockedRatesSuccessApi: ApiClient {
    
    var mockContentData: Data {
        return getJsonMockData(name: "Rates")
    }
    
    func getData(of request: RequestBuilder, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let response: Rates? = mockContentData.parse()
        
        completion(.success(try! JSONEncoder().encode(response)))
    }
    
    func getJsonMockData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
