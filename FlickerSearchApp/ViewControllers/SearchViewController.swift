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
    var searchQuery = "" {
        didSet{
            loadSearch(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
}
