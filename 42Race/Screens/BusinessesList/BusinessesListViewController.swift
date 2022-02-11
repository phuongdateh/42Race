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

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "\(BusinessCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BusinessCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBusinesses { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        } failure: {
            // Should show alert
        }
    }

}

extension BusinessesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BusinessCell.self)", for: indexPath) as! BusinessCell
        let data = viewModel.dataForCell(at: indexPath)
        cell.imageView.download(urlString: data.imageUrl ?? "")
        cell.nameLbl.text = data.name
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.dataForCell(at: indexPath)
    }
}

extension BusinessesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.collectionView.frame.size.width / 2 - 20
        return CGSize(width: width, height: width + 55)
    }
}
