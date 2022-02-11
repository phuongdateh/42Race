//
//  BusinessesListViewModel.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import Foundation

protocol BusinessesListViewModelType {
    func fetchBusinesses(success: (() -> Void)?,
                         failure: (() -> Void)?)
    func numberOfItems() -> Int
    func dataForCell(at indexPath: IndexPath) -> Business
}

class BusinessesListViewModel: BusinessesListViewModelType {

    let businessData: String
    let searchType: SearchBusinessType
    let networkManager: ApiProtocol

    init(businessData: String,
         searchType: SearchBusinessType,
         networkManager: ApiProtocol = NetworkManager.shared) {
        self.businessData = businessData
        self.networkManager = networkManager
        self.searchType = searchType
    }

    var businesses = [Business]()

    func fetchBusinesses(success: (() -> Void)?,
                         failure: (() -> Void)?) {
        switch searchType {
        case .business:
            networkManager.searchByBusinesses(name: businessData) { [weak self] results in
                self?.handleResults(success: success, failure: failure, results: results)
            }
        case .phone:
            networkManager.searchByPhone(phone: businessData) { [weak self] results in
                self?.handleResults(success: success, failure: failure, results: results)
            }
        }
    }

    func handleResults(success: (() -> Void)?,
                       failure: (() -> Void)?,
                       results: Result<SearchBusinessesResults, ErrorData>) {
        switch results {
        case .success(let data):
            businesses = data.businesses
            success?()
        case .failure(let error):
            print(error.localizedDescription)
            failure?()
        }
    }

    func numberOfItems() -> Int {
        return businesses.count
    }

    func dataForCell(at indexPath: IndexPath) -> Business {
        return businesses[indexPath.row]
    }
}
