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
    
    var path: GMSMutablePath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        
        self.pathCollectionView.register(UINib(nibName: "TravelSpotCell", bundle: nil), forCellWithReuseIdentifier: "spotcell")
        pathCollectionView.delegate = self
        pathCollectionView.dataSource = self
        
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
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
}

extension WriteMapController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        print("update")
    }
}

extension WriteMapController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TravelSpotCell = pathCollectionView.dequeueReusableCell(withReuseIdentifier: "spotcell", for: indexPath) as! TravelSpotCell
        //let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotcell", for: indexPath)
        
        cell.spotName.text = "test+\(indexPath.row)"
        
        return cell
    }
}
