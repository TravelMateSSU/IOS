//
//  WriteMapController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 20..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import GoogleMaps

class WriteMapController: UIViewController{
    @IBOutlet weak var mapContainerView: GMSMapView!
    @IBOutlet weak var pathCollectionView: UICollectionView!
    
    var searchController: UISearchController!
    var SearchResultCollectionView: UICollectionView!
    
    let courseCategoryCode = "C01"
    let pathCVIdentifier = "PathCell"
    let AutoCompleteCVIdentifier = "SearchResultCell"
    
    let tourAPIManager: TourAPIManager = TourAPIManager()
    var searchResult: [SpotModel] = []
    var selectedSpots: [SpotModel] = []
    
    var path: GMSMutablePath!
    var polyline: GMSPolyline!
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationSearchBar()
        
        initPathCollectionView()
        
        initMapData()
        
        initTourAPIManager()
        
        initAutoComplete()
    }

    func initNavigationSearchBar(){
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    func initAutoComplete(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 90, height: 77)
        layout.scrollDirection = .horizontal

        SearchResultCollectionView = UICollectionView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!+20, width: self.view.frame.width, height: 80), collectionViewLayout: layout)
        self.SearchResultCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil) , forCellWithReuseIdentifier: AutoCompleteCVIdentifier)
        
        SearchResultCollectionView.backgroundColor = UIColor.white
        SearchResultCollectionView.delegate = self
        SearchResultCollectionView.dataSource = self
        SearchResultCollectionView.isScrollEnabled = true
    }
    
    func initPathCollectionView(){
        self.pathCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil), forCellWithReuseIdentifier: pathCVIdentifier)
        
        pathCollectionView.delegate = self
        pathCollectionView.dataSource = self
    }
    
    func initMapData(){
        path = GMSMutablePath()
        polyline = GMSPolyline()
    }
    
    func initTourAPIManager(){
        
    }
    
    func mapPolylineUpdateByPath(path: GMSPath){
        polyline.map = nil // 이전 경로를 지도에서 지움
        
        polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 2
        polyline.map = mapContainerView
    }
    
    func mapCameraUpdateToPath(path: GMSPath){
        let bounds = GMSCoordinateBounds(path: path)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        mapContainerView.animate(with: update)
    }
    
    func mapCameraUpdateToMarker(marker: GMSMarker){
        let update = GMSCameraUpdate.setTarget(marker.position, zoom: 15)
        mapContainerView.animate(with: update)
    }
}

extension WriteMapController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {

        tourAPIManager.querySearchByKeyword(keyword: searchController.searchBar.text!, completion: {spots in
            self.searchResult = spots
            
            self.SearchResultCollectionView.reloadData()
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.addSubview(self.SearchResultCollectionView)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        SearchResultCollectionView.removeFromSuperview()
    }
}

extension WriteMapController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case pathCollectionView:
            return selectedSpots.count
        case SearchResultCollectionView:
            return searchResult.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case pathCollectionView:
            let cell: TravelSpotCell = pathCollectionView.dequeueReusableCell(withReuseIdentifier: pathCVIdentifier, for: indexPath) as! TravelSpotCell
            
            cell.spotName.text = selectedSpots[indexPath.row].title
            
            return cell
        case SearchResultCollectionView:
            let cell: TravelSpotCell = SearchResultCollectionView.dequeueReusableCell(withReuseIdentifier: AutoCompleteCVIdentifier, for: indexPath) as! TravelSpotCell
            
            cell.spotName.text = searchResult[indexPath.row].title
            
            if searchResult[indexPath.row].category1?.code == courseCategoryCode{
                cell.backgroundColor = UIColor.brown
            } else{
                cell.backgroundColor = UIColor.orange
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case pathCollectionView:
            return
        case SearchResultCollectionView:
            let selectedSpot = searchResult[indexPath.row]
            
            if selectedSpot.category1?.code == courseCategoryCode{
                
            } else{
                selectedSpots.append(selectedSpot)
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(selectedSpot.y, selectedSpot.x)
                marker.title = selectedSpot.title
                marker.map = mapContainerView
                
                markers.append(marker)
                path.add(marker.position)
                
                mapPolylineUpdateByPath(path: path)
                
                // camera update
                if markers.count < 2 {
                    mapCameraUpdateToMarker(marker: marker)
                } else{
                    mapCameraUpdateToPath(path: path)
                }
            }
            
            pathCollectionView.reloadData()
            
        default:
            return
        }
    }
}
