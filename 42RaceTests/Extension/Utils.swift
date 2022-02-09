//
//  Utils.swift
//  42RaceTests
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

class TestUtilities {
    static func makeSut<T: Decodable>(from data: Data) -> T {
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
