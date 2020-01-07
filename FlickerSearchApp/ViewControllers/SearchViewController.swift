//
//  ViewController.swift
//  FlickerSearchApp
//
//  Created by casandra grullon on 1/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var photo = [Photo](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var searchQuery = "pizza" {
        didSet{
            loadSearch(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearch(for: "pizza")
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadSearch(for search: String){
        PhotoAPIClient.getSearchResults(for: search) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photo = photos
                }
            }
        }
    }

}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("search cell not working properly")
        }
        let searchResult = photo[indexPath.row]
        cell.configureCell(for: searchResult)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText
    }

}
