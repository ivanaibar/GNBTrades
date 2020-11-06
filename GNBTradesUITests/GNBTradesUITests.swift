//
//  GNBTradesUITests.swift
//  GNBTradesUITests
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import XCTest

final class GNBTradesUITests: XCTestCase {

    func testOpenTransactionsView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables
            .children(matching: .cell)
            .element(boundBy: 0)
            .children(matching: .other)
            .element
            .children(matching: .other)
            .element
            .tap()
        XCTAssertTrue(app.otherElements["transactions_view"].exists)
    }
}
