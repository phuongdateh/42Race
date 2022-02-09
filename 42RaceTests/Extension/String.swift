//
//  String.swift
//  42RaceTests
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
