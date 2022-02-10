//
//  BusinessDetailTests.swift
//  42RaceTests
//
//  Created by Thomas on 09/02/2022.
//

import XCTest
@testable import _2Race

class BusinessDetailTests: XCTestCase {

    var sut: BusinessDetailResult!

    override func setUp() {
        sut = TestUtilities.makeSut(from: sampleData)
    }

    func testCorrectDecoding() {
        XCTAssertEqual(sut.id, "-9g5fZ0w0w3teWOO69nqmw")
        XCTAssertEqual(sut.alias, "radiator-coffee-salon-san-francisco")
        XCTAssertEqual(sut.name, "Radiator Coffee Salon")
    }

    let sampleData: Data = """
    {
        "id": "-9g5fZ0w0w3teWOO69nqmw",
        "alias": "radiator-coffee-salon-san-francisco",
        "name": "Radiator Coffee Salon",
        "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Jj8HGHTdT0wRdlU46M7mvg/o.jpg",
        "is_claimed": true,
        "is_closed": false,
        "url": "https://www.yelp.com/biz/radiator-coffee-salon-san-francisco?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=tmQxOl0ZSAOXexlkLyPjSg",
        "phone": "+14159470700",
        "display_phone": "(415) 947-0700",
        "review_count": 10,
        "categories": [
            {
                "alias": "coffee",
                "title": "Coffee & Tea"
            },
            {
                "alias": "breakfast_brunch",
                "title": "Breakfast & Brunch"
            },
            {
                "alias": "sandwiches",
                "title": "Sandwiches"
            }
        ],
        "rating": 4.0,
        "location": {
            "address1": "299 2nd St",
            "address2": "",
            "address3": null,
            "city": "San Francisco",
            "zip_code": "94105",
            "country": "US",
            "state": "CA",
            "display_address": [
                "299 2nd St",
                "San Francisco, CA 94105"
            ],
            "cross_streets": "Folsom St & Clementina St"
        },
        "coordinates": {
            "latitude": 37.78577571880986,
            "longitude": -122.39671881226874
        },
        "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/Jj8HGHTdT0wRdlU46M7mvg/o.jpg",
            "https://s3-media2.fl.yelpcdn.com/bphoto/jlp-gU10HYo6ZugScFndDw/o.jpg",
            "https://s3-media1.fl.yelpcdn.com/bphoto/tYWVH7q8iQs_Ntd7OJ5SFA/o.jpg"
        ],
        "hours": [
            {
                "open": [
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 0
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 1
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 2
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 3
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 4
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 5
                    },
                    {
                        "is_overnight": false,
                        "start": "0600",
                        "end": "1100",
                        "day": 6
                    }
                ],
                "hours_type": "REGULAR",
                "is_open_now": false
            }
        ],
        "transactions": [],
        "messaging": {
            "url": "https://www.yelp.com/raq/-9g5fZ0w0w3teWOO69nqmw?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=tmQxOl0ZSAOXexlkLyPjSg#popup%3Araq",
            "use_case_text": "Message the Business"
        }
    }
    """.utf8Encoded
}
