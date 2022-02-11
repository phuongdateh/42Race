//
//  BusinessesListViewController.swift
//  42Race
//
//  Created by Thomas on 11/02/2022.
//

import UIKit

class BusinessesListViewController: ViewController {

    let viewModel: BusinessesListViewModelType
    
    init(viewModel: BusinessesListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
