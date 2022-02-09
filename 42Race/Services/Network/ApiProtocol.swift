//
//  ApiProtocol.swift
//  42Race
//
//  Created by Thomas on 09/02/2022.
//

import Foundation

protocol ApiProtocol {
    func getAutocomplete()
    func searchByBusinesses()
    func searchByPhone()
    func getBusinessesDetail(id: String)
}
