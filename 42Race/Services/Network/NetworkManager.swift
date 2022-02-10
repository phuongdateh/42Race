//
//  NetworkManager.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

final class NetworkManager: ApiProtocol {
    static let shared = NetworkManager()
    var provider: URLSession

    init(provider: URLSession = URLSession.shared) {
        self.provider = provider
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
