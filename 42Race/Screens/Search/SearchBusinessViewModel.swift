//
//  SearchBusinessViewModel.swift
//  42Race
//
//  Created by Thomas on 10/02/2022.
//

import Foundation

protocol SearchBusinessViewModelType {
    func numberOfRow() -> Int
    func dataForCell(indexPath: IndexPath) -> String
    func autoComplete(for keyword: String, completion: (() -> Void)?)
}

final class SearchBusinessViewModel: SearchBusinessViewModelType {
    let networkManager: NetworkManager
    let debouncer: Debouncer

    init(networkManager: NetworkManager = NetworkManager.shared,
         debouncer: Debouncer = Debouncer(delay: 0.5)) {
        self.networkManager = networkManager
        self.debouncer = debouncer
    }

    var categories = [Category]()

    func dataForCell(indexPath: IndexPath) -> String {
        return categories[indexPath.row].title
    }

    func numberOfRow() -> Int {
        return categories.count
    }

    func autoComplete(for keyword: String, completion: (() -> Void)?) {
        networkManager.getAutocomplete(text: keyword) { [weak self] result in
            switch result {
            case .success(let data):
                self?.categories = data.categories
                completion?()
            case .failure(let error):
                completion?()
            }
        }
    }
}
