//
//  UIImageView.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func download(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        kf.setImage(with: url)
    }
}
