//
//  BusinessDetail.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct BusinessDetailResult: Decodable {
    let id: String
    let alias: String?
    let name: String?
    let imageUrl: String?
    var isClosed: Bool = false
    var reviewCount: Int = 0
    var rating: Double = 0
    var photos = [String]()
    let displayPhone: String?
    var categories = [Category]()
    var hours = [BusinessHoursOperation]()
    let location: BusinessLocation?

    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case rating
        case photos
        case displayPhone = "display_phone"
        case categories
        case hours
        case location
    }

    func getHoursOperation() -> String {
        let data = hours.first
        let firstObj = data?.open.first
        let start = firstObj?.start ?? ""
        let end = firstObj?.end ?? ""
        return "\(data?.isOpenNow == true ? "Open" : "Closed") \(insertCharacter(text: start)) - \(insertCharacter(text: end))"
    }

    func insertCharacter(text: String) -> String {
        var newText = text
        let insertIndex = newText.index(newText.startIndex, offsetBy: 2)
        newText.insert(":", at: insertIndex)
        return newText
    }
}

