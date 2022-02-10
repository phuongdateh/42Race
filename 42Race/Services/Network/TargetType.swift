//
//  TargetType.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var sampleData: Data { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}
