//
//  SearchBusinessViewController.swift
//  42Race
//
//  Created by Thomas on 01/02/2022.
//

import UIKit

/*
 ● Code must be written in Swift
 ● Must run on iOS 12+
 ● Use only MVVM design pattern
 ● You may use any third-party libraries
 ● Search by business name
 ● Search by address/city/postal code
 ● Search by cuisine type
 ● Sorting of results by distance and ratings
 ● Detailed view of a result should include the following:
 a. Name and photo of business
 b. Categories
 c. Hours of operation
 d. Address and contact information
 e. Ratings and snippet
 f. Deals
 ● Creativity in adding any other feature not mentioned above will be counted as a bonus.
 ● Code with Unit Testing is a plus
 */

enum SearchBusinessType: Int {
    case business
    case phone
}

class SearchBusinessViewController: ViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel: SearchBusinessViewModelType
    
    init(viewModel: SearchBusinessViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var searchType: Int = SearchBusinessType.business.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        view.backgroundColor = .white

        segmentedControl.setTitle("Business", forSegmentAt: 0)
        segmentedControl.setTitle("Phone", forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChange(_:)), for: .valueChanged)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "\(AutoCompleteCell.self)", bundle: nil), forCellReuseIdentifier: "\(AutoCompleteCell.self)")
        tableView.delegate = self
        tableView.dataSource = self

        searchBar.delegate = self
        searchBar.resignFirstResponder()
        searchBar.returnKeyType = .search
    }

    @objc func segmentedControlValueChange(_ sender: UISegmentedControl) {
        searchType = sender.selectedSegmentIndex
//        searchBar.keyboardType = searchType == SearchBusinessType.business.rawValue ? .default : .numberPad
//        searchBar.reloadInputViews()
    }
}

extension SearchBusinessViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(AutoCompleteCell.self)", for: indexPath) as! AutoCompleteCell
        cell.titleLbl.text = viewModel.dataForCell(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = viewModel.dataForCell(indexPath: indexPath)
        let viewModel = BusinessesListViewModel(businessData: text, searchType: searchType == 0 ? .business : .phone)
        let vc = BusinessesListViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchBusinessViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.autoComplete(for: searchText) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("asdasdasdas")
        if searchType == SearchBusinessType.phone.rawValue {
            // go to  list page
        }
        searchBar.resignFirstResponder()
    }
}
