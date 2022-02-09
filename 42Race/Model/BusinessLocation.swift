//
//  BusinessLocation.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct BusinessLocation: Decodable {
    let crossStreets: String?
    var displayAddress = [String]()

    enum CodingKeys: String, CodingKey {
        case crossStreets = "cross_streets"
        case displayAddress = "display_address"
    }
}
