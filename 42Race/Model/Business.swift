//
//  Business.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct Business: Decodable {
    let id: String
    let alias: String?
    let name: String?
    let imageUrl: String?
    var isClosed: Bool = false
    var reviewCount: Int = 0
    var rating: Double = 0

    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case rating
    }
}
