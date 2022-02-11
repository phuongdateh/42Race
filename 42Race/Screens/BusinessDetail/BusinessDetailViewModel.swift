//
//  BusinessDetailViewModel.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import Foundation

protocol BusinessDetailViewModelType {
    func fetchDetail(success: (() -> Void)?,
                     failure: (() -> Void)?)
    func getDetail() -> BusinessDetailResult?
}

class BusinessDetailViewModel: BusinessDetailViewModelType {
    let api: ApiProtocol
    let businessId: String

    init(businessId: String,
         api: ApiProtocol = NetworkManager.shared) {
        self.businessId = businessId
        self.api = api
    }

    var data: BusinessDetailResult?

    func fetchDetail(success: (() -> Void)?,
                     failure: (() -> Void)?) {
        api.getBusinessesDetail(id: businessId) { [weak self] results in
            switch results {
            case .success(let data):
                self?.data = data
                success?()
            case .failure:
                failure?()
            }
        }
    }

    func getDetail() -> BusinessDetailResult? {
        return data
    }
}
