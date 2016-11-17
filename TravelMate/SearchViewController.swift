//
//  SearchViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let networkManager = NetworkManager()
    
    var spots: [SpotModel] = []
    
    var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
        createSubView()
    }
    
    
    func createSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
    }
    
    func createSubView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "SearchPreviewCell", bundle: nil), forCellReuseIdentifier: "SearchPreviewCell")
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var tourapi = TourAPIManager()
        
        tourapi.querySearchByKeyword(keyword: searchText, completion: { spots in
            self.spots = spots
            self.tableView.reloadData()
        })
        
//        networkManager.loadSpotsByKeyword(keyword: searchText, {
//            spots, code in
//            if code == 200 {
//                print("성공")
//                guard let spots = spots else {
//                    print("Spots 데이터 없음")
//                    return
//                }
//                self.spots = spots
//                self.tableView.reloadData()
//            } else {
//                print("실패")
//            }
//        })
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPreviewCell") as? SearchPreviewCell
        
        guard let previewCell = cell else {
            return UITableViewCell()
        }
        
        let spot = spots[indexPath.row]
        previewCell.spot = spot
        previewCell.titleLabel.text = spot.title
        
        return previewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Course", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchDetailViewController") as? SearchDetailViewController
        
        if let searchDetailViewController = vc {
            self.searchBar.endEditing(true)
            searchDetailViewController.spot = spots[indexPath.row]
            searchDetailViewController.keyword = self.spots[indexPath.row].title
            self.navigationController?.pushViewController(searchDetailViewController, animated: true)
        }
    }
}
