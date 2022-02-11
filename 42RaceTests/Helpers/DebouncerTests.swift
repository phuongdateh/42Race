//
//  DebouncerTests.swift
//  42RaceTests
//
//  Created by Thomas on 11/02/2022.
//

import XCTest
@testable import _2Race

class DebouncerTests: XCTestCase {

    var deboucer: Debouncer!
    
    override func setUp() {
        self.deboucer = Debouncer(delay: 2)
    }
    
    func testCall() {
        var isCalled: Bool = false
        let expectation = self.expectation(description: "isCalled should equal true")
        deboucer.call(action: {
            isCalled = true
            XCTAssertTrue(isCalled)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
}
