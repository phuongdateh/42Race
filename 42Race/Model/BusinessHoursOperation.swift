//
//  BusinessHoursOperation.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct BusinessHoursOperation: Decodable {
    var open = [BusinessHourOperationDetail]()
    var isOpenNow: Bool = false

    enum CodingKeys: String, CodingKey {
        case isOpenNow = "is_open_now"
        case open
    }
}

struct BusinessHourOperationDetail: Decodable {
    let start: String?
    let end: String?
}
