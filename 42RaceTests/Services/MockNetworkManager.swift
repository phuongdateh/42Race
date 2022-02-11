//
//  MockNetworkManager.swift
//  42RaceTests
//
//  Created by Thomas on 11/02/2022.
//

import Foundation
@testable import _2Race

class MockNetworkManager: ApiProtocol {

    static let shared = MockNetworkManager()
    var provider: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        provider = URLSession(configuration: configuration)
    }

    func getAutocomplete(text: String,
                         completion: @escaping CompletionResult<AutoCompleteResults>) {
        request(target: .autocomplete(text), completion)
    }
    
    func searchByBusinesses(name: String,
                            completion: @escaping CompletionResult<SearchBusinessesResults>) {
        request(target: .searchByBusinesses(name), completion)
    }
    
    func searchByPhone(phone: String,
                       completion: @escaping CompletionResult<SearchBusinessesResults>) {
        request(target: .searchByPhone(phone), completion)
    }
    
    func getBusinessesDetail(id: String,
                             completion: @escaping CompletionResult<BusinessDetailResult>) {
        request(target: .getBusinessDetail(id), completion)
    }
}
