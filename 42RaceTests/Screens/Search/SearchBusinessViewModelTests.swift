//
//  SearchBusinessViewModelTests.swift
//  42RaceTests
//
//  Created by Thomas on 11/02/2022.
//

import XCTest
@testable import _2Race

class SearchBusinessViewModelTests: XCTestCase {

    var sut: SearchBusinessViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        mockNetworkManager = MockNetworkManager.shared
        sut = SearchBusinessViewModel(networkManager: mockNetworkManager)
    }

    func testGetAutocompletionSuccess() {
        let expectation = expectation(description: "should return an list categories")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.autocomplete("").sampleData)
        }

        sut.autoComplete(for: "test") {
            XCTAssertFalse(self.sut.categories.isEmpty)
            XCTAssertTrue(self.sut.numberOfRow() > 0)
            let expexted = "Coffee & Tea"
            XCTAssertEqual(self.sut.dataForCell(indexPath: IndexPath(row: 0, section: 0)), expexted)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetAutocompletionFailure() {
        let expectation = expectation(description: "should not return an list categories")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        sut.autoComplete(for: "test") {
            XCTAssertTrue(self.sut.categories.isEmpty)
            XCTAssertTrue(self.sut.numberOfRow() == 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
