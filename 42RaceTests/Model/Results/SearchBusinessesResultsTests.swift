//
//  SearchBusinessesResultsTests.swift
//  42RaceTests
//
//  Created by Thomas on 09/02/2022.
//

import XCTest
@testable import _2Race

class SearchBusinessesResultsTests: XCTestCase {
    
    func testCorrectDecodingSearchByBusinesses() {
        let sut: SearchBusinessesResults = TestUtilities.makeSut(from: businessData)
        let firstObj = sut.businesses.first
        XCTAssertFalse(sut.businesses.isEmpty)
        XCTAssertEqual(firstObj?.id, "cQfRu22j4nAuycKWHexAIA")
        XCTAssertEqual(firstObj?.name, "Réveille Coffee Co.")
    }

    let businessData: Data = """
    {
      "businesses": [
        {
          "id": "cQfRu22j4nAuycKWHexAIA",
          "alias": "réveille-coffee-co-san-francisco-5",
          "name": "Réveille Coffee Co.",
          "image_url": "https://s3-media3.fl.yelpcdn.com/bphoto/negJx3BNhMOM2-fIuLcEJg/o.jpg",
          "is_closed": false,
          "url": "https://www.yelp.com/biz/r%C3%A9veille-coffee-co-san-francisco-5?adjust_creative=tmQxOl0ZSAOXexlkLyPjSg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=tmQxOl0ZSAOXexlkLyPjSg",
          "review_count": 434,
          "categories": [
            {
              "alias": "coffee",
              "title": "Coffee & Tea"
            }
          ],
          "rating": 4,
          "coordinates": {
            "latitude": 37.7972059782064,
            "longitude": -122.405463418284
          },
          "transactions": [
            "delivery"
          ],
          "price": "$$",
          "location": {
            "address1": "200 Columbus Ave",
            "address2": null,
            "address3": "",
            "city": "San Francisco",
            "zip_code": "94133",
            "country": "US",
            "state": "CA",
            "display_address": [
              "200 Columbus Ave",
              "San Francisco, CA 94133"
            ]
          },
          "phone": "+14157896258",
          "display_phone": "(415) 789-6258",
          "distance": 1245.2632727382581
        }
      ],
      "total": 2300,
      "region": {
        "center": {
          "longitude": -122.399972,
          "latitude": 37.786882
        }
      }
    }
    """.utf8Encoded
}
