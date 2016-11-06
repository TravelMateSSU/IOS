//
//  SearchViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: searchText, completion: {
                spots in
                
            })
        #else
        
        #endif
    }
}
