//
//  AutoCompleteResults.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

struct AutoCompleteResults: Decodable {
    var categories = [Category]()
    var businesses = [Business]()
}
