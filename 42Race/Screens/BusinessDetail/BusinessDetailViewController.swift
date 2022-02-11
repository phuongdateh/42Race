//
//  BusinessDetailViewController.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import UIKit

class BusinessDetailViewController: ViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingCountLbl: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var openTimeLbl: UILabel!
    
    let viewModel: BusinessDetailViewModelType
    
    init(viewModel: BusinessDetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDetail { [weak self] in
            guard let data = self?.viewModel.getDetail() else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageView.download(urlString: data.imageUrl ?? "")
                self?.nameLbl.text = data.name
                self?.ratingView.rating = data.rating
                self?.ratingCountLbl.text = "\(data.reviewCount) reviews"
                self?.openTimeLbl.text = data.getHoursOperation()
            }
        } failure: {
            // Should show alert
        }

    }
}
