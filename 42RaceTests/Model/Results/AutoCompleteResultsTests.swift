//
//  AutoCompleteResultsTests.swift
//  42RaceTests
//
//  Created by Thomas on 09/02/2022.
//

import XCTest
@testable import _2Race

class AutoCompleteResultsTests: XCTestCase {

    func testCorrectDecoding() {
        let sut: AutoCompleteResults = TestUtilities.makeSut(from: data)
        let firstCategory = sut.categories.first

        XCTAssertFalse(sut.categories.isEmpty)
        XCTAssertEqual(firstCategory?.title, "Coffee & Tea")
        XCTAssertEqual(firstCategory?.alias, "coffee")
    }
    
    let data: Data = """
    {
        "categories": [
            {
                "alias": "coffee",
                "title": "Coffee & Tea"
            },
            {
                "alias": "tea",
                "title": "Tea Rooms"
            },
            {
                "alias": "teachersupplies",
                "title": "Teacher Supplies"
            }
        ],
        "businesses": [],
        "terms": [
            {
                "text": "Tea"
            },
            {
                "text": "Tea Shop"
            },
            {
                "text": "Tea House"
            }
        ]
    }
    """.utf8Encoded

}
