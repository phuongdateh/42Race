//
//  NetworkManagerTests.swift
//  42RaceTests
//
//  Created by Thomas on 10/02/2022.
//

import XCTest
@testable import _2Race

class NetworkManagerTests: XCTestCase {
    var urlSession: URLSession!
    var networkManager: NetworkManager!
    var stubData: Data!

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        networkManager = NetworkManager(provider: urlSession)
    }

    func testGetAutocompleteSuccess() {
        let expectation = expectation(description: "should return an list categories")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.autocomplete("").sampleData)
        }

        networkManager.getAutocomplete(text: "test") { result in
            switch result {
            case .success(let data):
                expectation.fulfill()
                XCTAssertFalse(data.categories.isEmpty)
            default:
                break
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetAutocompleteFailure() {
        let expectation = expectation(description: "should excute falure block")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        networkManager.getAutocomplete(text: "test") { result in
            switch result {
            case .failure(_):
                expectation.fulfill()
            default:
                break
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchByBusinessSucessful() {
        let expectation = expectation(description: "should return an list businesses")
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.searchByBusinesses("").sampleData)
        }

        networkManager.searchByBusinesses(name: "test") { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.businesses.isEmpty)
                expectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchByBusinessFailure() {
        let expectation = expectation(description: "should excute failure block")

        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        networkManager.searchByBusinesses(name: "test") { result in
            switch result {
            case .failure:
                expectation.fulfill()
            default:
                break
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchByPhoneSucessful() {
        let expectation = expectation(description: "should return an list businesses")
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.searchByPhone("").sampleData)
        }

        networkManager.searchByBusinesses(name: "123123123") { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.businesses.isEmpty)
                expectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchByPhoneFailure() {
        let expectation = expectation(description: "should excute failure block")
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        networkManager.searchByBusinesses(name: "123123123") { result in
            switch result {
            case .failure:
                expectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetBusinessDetailSucessful() {
        let expectation = expectation(description: "should return an businesses detail")
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), ApiTarget.getBusinessDetail("").sampleData)
        }

        networkManager.getBusinessesDetail(id: "-9g5fZ0w0w3teWOO69nqmw") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.id, "-9g5fZ0w0w3teWOO69nqmw")
                expectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetBusinessDetailFailure() {
        let expectation = expectation(description: "should excute failure block")
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), Data())
        }

        networkManager.getBusinessesDetail(id: "-9g5fZ0w0w3teWOO69nqmw") { result in
            switch result {
            case .failure:
                expectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
