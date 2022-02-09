//
//  SearchBusinessesResults.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct SearchBusinessesResults: Decodable {
    var businesses = [Business]()
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case businesses
        case total
    }
}
