//
//  BusinessCell.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import UIKit

class BusinessCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill

        nameLbl.numberOfLines = 2
    }

}
