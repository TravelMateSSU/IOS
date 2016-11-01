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
    var autoCompleteCollectionView: UICollectionView!
    
    let pathCVIdentifier = "PathCell"
    let AutoCompleteCVIdentifier = "AutoCompleteCell"
    
    var path: GMSMutablePath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initAutoComplete()
        //autoCompleteCollectionView.removeFromSuperview()
        
        initPathCollectionView()
        
        initMapData()
        
    }
    
    @IBAction func testAction(_ sender: AnyObject) {
        let bounds = GMSCoordinateBounds(path: path)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        mapContainerView.animate(with: update)
    }
    
    func initNavigationBar(){
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

        autoCompleteCollectionView = UICollectionView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!+20, width: self.view.frame.width, height: 80), collectionViewLayout: layout)
        self.autoCompleteCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil) , forCellWithReuseIdentifier: AutoCompleteCVIdentifier)
        
        autoCompleteCollectionView.backgroundColor = UIColor.white
        
        autoCompleteCollectionView.delegate = self
        autoCompleteCollectionView.dataSource = self
        autoCompleteCollectionView.isScrollEnabled = true
        
    }
    
    func initPathCollectionView(){
        self.pathCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil), forCellWithReuseIdentifier: pathCVIdentifier)
        
        pathCollectionView.delegate = self
        pathCollectionView.dataSource = self
    }
    
    func initMapData(){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(37.5693679015, 126.9838371210)
        marker.title = "가마목"
        marker.map = mapContainerView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(37.5706149055, 126.9797346814)
        marker2.title = "광화문 미진"
        marker2.map = mapContainerView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2DMake(37.5655100385, 126.9850482312)
        marker3.title = "나석주의사동상"
        marker3.map = mapContainerView
        
        path = GMSMutablePath()
        path.add(CLLocationCoordinate2DMake(37.5693679015, 126.9838371210))
        path.add(CLLocationCoordinate2DMake(37.5706149055, 126.9797346814))
        path.add(CLLocationCoordinate2DMake(37.5655100385, 126.9850482312))
        path.add(CLLocationCoordinate2DMake(37.496375, 126.9546903))
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3
        polyline.map = mapContainerView
    }
}

extension WriteMapController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("test")

        self.view.addSubview(self.autoCompleteCollectionView)

        //initAutoComplete()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("test end")
        autoCompleteCollectionView.removeFromSuperview()
    }
}

extension WriteMapController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case pathCollectionView:
            return 5
        default:
            return 5
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case pathCollectionView:
            let cell: TravelSpotCell = pathCollectionView.dequeueReusableCell(withReuseIdentifier: pathCVIdentifier, for: indexPath) as! TravelSpotCell
            
            cell.spotName.text = "test+\(indexPath.row)"
            
            return cell
        default:
            let cell: TravelSpotCell = autoCompleteCollectionView.dequeueReusableCell(withReuseIdentifier: AutoCompleteCVIdentifier, for: indexPath) as! TravelSpotCell
            
            cell.spotName.text = "auto\(indexPath.row)"
            
            return cell
        }
    }
}
