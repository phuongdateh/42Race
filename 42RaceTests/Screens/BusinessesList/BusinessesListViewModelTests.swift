//
//  BusinessesListViewModelTests.swift
//  42RaceTests
//
//  Created by Thomas on 11/02/2022.
//

import XCTest
@testable import _2Race

class BusinessesListViewModelTests: XCTestCase {
    var sut: BusinessesListViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        mockNetworkManager = MockNetworkManager.shared
    }

    func testGetBusinessesWithBusinessNameSuccess() {
        sut = BusinessesListViewModel(businessData: "coffee", searchType: .business, networkManager: mockNetworkManager)
        let expectation = expectation(description: "should return an list businesses")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.searchByBusinesses("").sampleData)
        }

        sut.fetchBusinesses {
            expectation.fulfill()
            XCTAssertFalse(self.sut.businesses.isEmpty)
            XCTAssertTrue(self.sut.numberOfItems() > 0)
            let expectedFirstId = "cQfRu22j4nAuycKWHexAIA"
            XCTAssertEqual(self.sut.dataForCell(at: IndexPath(row: 0, section: 0)).id, expectedFirstId)
        } failure: {
            XCTFail("should not excute here")
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetBusinessesWithBusinessNameFailure() {
        sut = BusinessesListViewModel(businessData: "coffee", searchType: .business, networkManager: mockNetworkManager)
        let expectation = expectation(description: "should excute failure block")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        sut.fetchBusinesses {
            XCTFail("should not excute here")
        } failure: {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetBusinessesWithBusinessPhoneSuccess() {
        sut = BusinessesListViewModel(businessData: "123123", searchType: .phone, networkManager: mockNetworkManager)
        let expectation = expectation(description: "should return an list businesses")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.searchByPhone("").sampleData)
        }

        sut.fetchBusinesses {
            expectation.fulfill()
            XCTAssertFalse(self.sut.businesses.isEmpty)
            XCTAssertTrue(self.sut.numberOfItems() > 0)
            let expectedFirstId = "cQfRu22j4nAuycKWHexAIA"
            XCTAssertEqual(self.sut.dataForCell(at: IndexPath(row: 0, section: 0)).id, expectedFirstId)
        } failure: {
            XCTFail("should not excute here")
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetBusinessesWithBusinessPhoneFailure() {
        sut = BusinessesListViewModel(businessData: "123123", searchType: .phone, networkManager: mockNetworkManager)
        let expectation = expectation(description: "should return an list businesses")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        sut.fetchBusinesses {
            XCTFail("should not excute here")
        } failure: {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

}
