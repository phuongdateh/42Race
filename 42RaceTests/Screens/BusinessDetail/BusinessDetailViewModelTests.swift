//
//  BusinessDetailViewModelTests.swift
//  42RaceTests
//
//  Created by Thomas on 12/02/2022.
//

import XCTest
@testable import _2Race

class BusinessDetailViewModelTests: XCTestCase {

    var sut: BusinessDetailViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        mockNetworkManager = MockNetworkManager.shared
        sut = BusinessDetailViewModel(businessId: "123", api: mockNetworkManager)
    }

    func testFetchDetailSuccess() {
        let expectation = expectation(description: "should return an object detail")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.getBusinessDetail("").sampleData)
        }

        sut.fetchDetail {
            XCTAssertNotNil(self.sut.getDetail())
            expectation.fulfill()
        } failure: {
            XCTFail("should not excute here")
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchDetailFailure() {
        let expectation = expectation(description: "should return an object detail")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        sut.fetchDetail {
            XCTFail("should not excute here")
        } failure: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

}
