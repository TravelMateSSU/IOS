//
//  WriteMapController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 20..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class WriteMapController: UIViewController{
    @IBOutlet weak var mapContainerView: GMSMapView!
    @IBOutlet weak var SelectedSpotsCollectionView: UICollectionView!
    
    var searchController: UISearchController!
    var searchResultCollectionView: UICollectionView!
    
    let CourseCategoryCode = "C01"
    let SelectedSpotsCVIdentifier = "PathCell"
    let SearchResultCVIdentifier = "SearchResultCell"
    
    let tourAPIManager: TourAPIManager = TourAPIManager()
    var searchResult: [SpotModel] = []
    var selectedSpots: [SpotModel] = []
    var searchResultImage: [UIImage] = []
    
    var path: GMSMutablePath!
    var polyline: GMSPolyline!
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationSearchBar()
        
        initPathCollectionView()
        
        initMapData()
        
        initAutoComplete()
    }

    func initNavigationSearchBar(){
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "가고싶은 장소나 코스를 입력해주세요"
        
        self.navigationItem.titleView = searchController.searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: nil)
        
        self.definesPresentationContext = true
    }
    
    func initAutoComplete(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 90, height: 77)
        layout.scrollDirection = .horizontal

        searchResultCollectionView = UICollectionView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!+20, width: self.view.frame.width, height: 80), collectionViewLayout: layout)
        self.searchResultCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil) , forCellWithReuseIdentifier: SearchResultCVIdentifier)

        searchResultCollectionView.backgroundColor = UIColor.white
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.isScrollEnabled = true
        searchResultCollectionView.isHidden = true
        
        self.view.addSubview(self.searchResultCollectionView)
    }
    
    func initPathCollectionView(){
        self.SelectedSpotsCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil), forCellWithReuseIdentifier: SelectedSpotsCVIdentifier)
        
        SelectedSpotsCollectionView.delegate = self
        SelectedSpotsCollectionView.dataSource = self
    }
    
    func initMapData(){
        mapContainerView.delegate = self
        
        path = GMSMutablePath()
        polyline = GMSPolyline()
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
    
    func hideKeyboard(){
        searchController.searchBar.endEditing(true)
    }
}

extension WriteMapController: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        hideKeyboard()
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        hideKeyboard()
    }
}

extension WriteMapController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {

        tourAPIManager.querySearchByKeyword(keyword: searchController.searchBar.text!, completion: {spots in

            self.searchResult = spots
            
            self.searchResultCollectionView.reloadData()
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = nil
        searchResultCollectionView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: nil)
        searchResultCollectionView.isHidden = true
    }
}

extension WriteMapController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case SelectedSpotsCollectionView:
            return selectedSpots.count
        case searchResultCollectionView:
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
        case SelectedSpotsCollectionView:
            let cell: TravelSpotCell = SelectedSpotsCollectionView.dequeueReusableCell(withReuseIdentifier: SelectedSpotsCVIdentifier, for: indexPath) as! TravelSpotCell
            
            cell.spotName.text = selectedSpots[indexPath.row].title
            
            return cell
        case searchResultCollectionView:
            let cell: TravelSpotCell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVIdentifier, for: indexPath) as! TravelSpotCell
            
            searchResultImage.append(UIImage(named: "full_placeholder")!)

            cell.spotImage.image = searchResultImage[indexPath.row]
            
            cell.spotName.text = searchResult[indexPath.row].title
            
            if searchResult[indexPath.row].category1?.code == CourseCategoryCode{
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
        case SelectedSpotsCollectionView:
            return
        case searchResultCollectionView:
            print("click")
            let selectedSpot = searchResult[indexPath.row]
            
            if selectedSpot.category1?.code == CourseCategoryCode{

            } else{
                hideKeyboard()
                
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
            
            SelectedSpotsCollectionView.reloadData()
            
        default:
            return
        }
    }
}
