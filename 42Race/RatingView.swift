//
//  RatingView.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import Foundation
import Cosmos

final class RatingView: CosmosView {
    
    var newSettings = CosmosSettings()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configuration()
    }
    
    private func configuration() {
        newSettings.updateOnTouch = false
        newSettings.totalStars = 5
        newSettings.fillMode = .precise
        newSettings.disablePanGestures = true
        newSettings.starSize = 16
        newSettings.filledBorderWidth = 1
        newSettings.filledImage = UIImage.init(named: "rating_filled_ic")?.withRenderingMode(.alwaysOriginal)
        if #available(iOS 13.0, *) {
            newSettings.emptyImage = UIImage.init(named: "rating_empty_ic")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white)
        }
        self.settings = newSettings
    }
}

