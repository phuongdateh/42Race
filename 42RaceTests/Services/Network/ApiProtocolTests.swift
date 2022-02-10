//
//  ApiProtocolTests.swift
//  42RaceTests
//
//  Created by Thomas on 10/02/2022.
//

import XCTest
@testable import _2Race

class ApiProtocolTests: XCTestCase {

    func testCreateURLRequestToGetAutocomplete() {
        let sut = ApiTarget.autocomplete("coffee")
        XCTAssertEqual(sut.method, "GET")
        XCTAssertEqual(sut.path, "autocomplete")
        XCTAssertEqual(sut.headers,
                       ["Authorization": "Bearer 7byU7a4D8EDQAra8qxeDA809AY3U55QB_4L08GSQRae_iDlRN1eQ_x8khvBr92mZpLXwoskwIPdCVbofh88HmlIOs5sUKkUbms-WD-B5LDceOde2joEf4k8bqSz2YXYx"])
    }

    func testCreateURLRequestToSearchByBusiness() {
        let sut = ApiTarget.searchByBusinesses("coffee")
        XCTAssertEqual(sut.method, "GET")
        XCTAssertEqual(sut.path, "businesses/search")
        XCTAssertEqual(sut.headers,
                       ["Authorization": "Bearer 7byU7a4D8EDQAra8qxeDA809AY3U55QB_4L08GSQRae_iDlRN1eQ_x8khvBr92mZpLXwoskwIPdCVbofh88HmlIOs5sUKkUbms-WD-B5LDceOde2joEf4k8bqSz2YXYx"])
    }

    func testCreateURLRequestToSearchByPhone() {
        let sut = ApiTarget.searchByPhone("14157539775")
        XCTAssertEqual(sut.method, "GET")
        XCTAssertEqual(sut.path, "businesses/search/phone")
        XCTAssertEqual(sut.headers,
                       ["Authorization": "Bearer 7byU7a4D8EDQAra8qxeDA809AY3U55QB_4L08GSQRae_iDlRN1eQ_x8khvBr92mZpLXwoskwIPdCVbofh88HmlIOs5sUKkUbms-WD-B5LDceOde2joEf4k8bqSz2YXYx"])
    }

    func testCreateURLRequestToGetBusinessDetail() {
        let sut = ApiTarget.getBusinessDetail("test")
        XCTAssertEqual(sut.method, "GET")
        XCTAssertEqual(sut.path, "businesses/test")
        XCTAssertEqual(sut.headers,
                       ["Authorization": "Bearer 7byU7a4D8EDQAra8qxeDA809AY3U55QB_4L08GSQRae_iDlRN1eQ_x8khvBr92mZpLXwoskwIPdCVbofh88HmlIOs5sUKkUbms-WD-B5LDceOde2joEf4k8bqSz2YXYx"])
    }

}
