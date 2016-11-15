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
    
    var nextBarButton: UIBarButtonItem! = nil
    var searchController: UISearchController!
    var searchResultCollectionView: UICollectionView!
    
    let CourseCategoryCode = "C01"
    let SelectedSpotsCVIdentifier = "PathCell"
    let SearchResultCVIdentifier = "SearchResultCell"
    
    let tourAPIManager: TourAPIManager = TourAPIManager()
    var searchResult: [SpotModel] = []
    var selectedSpots: [SpotModel] = []
    var searchResultImage: [UIImage] = []
    var seletedSpotsImage: [UIImage] = []
    
    var path: GMSMutablePath!
    var polyline: GMSPolyline!
    var markers: [GMSMarker] = []
    
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationSearchBar()
        
        initPathCollectionView()
        
        initMapAndCamera()
        
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
        nextBarButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(moveWriteDetail))
        self.navigationItem.rightBarButtonItem = nextBarButton
        
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
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.SelectedSpotsCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    func initMapAndCamera(){
        let update = GMSCameraUpdate.setTarget(CLLocationCoordinate2DMake(36.500606687587016, 127.73958139121531), zoom: 7)

        mapContainerView.moveCamera(update)
        
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
    
    func moveWriteDetail(){
        // 장소 한개 이상 선택해야 다음 작성 화면으로 넘어갈 수 있음.
        guard let count:Int = selectedSpots.count , count > 0 else { return }
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let writeMapDetailController = mainStoryBoard.instantiateViewController(withIdentifier: "writemapdetail") as! WriteMapDetailController
        writeMapDetailController.spots = selectedSpots
        
        self.navigationController?.pushViewController(writeMapDetailController, animated: true)
    }
    
    @IBAction func seletedEditButton(_ sender: AnyObject) {
        if editMode == false {
            editMode = true
        } else{
            editMode = false
        }
        
        SelectedSpotsCollectionView.reloadData()
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
        self.navigationItem.rightBarButtonItem = nextBarButton
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
            
            if editMode == true {
                cell.deleteButton.isHidden = false
            } else{
                cell.deleteButton.isHidden = true
            }
            
            seletedSpotsImage.append(UIImage(named: "full_placeholder")!)
            
            cell.spotImage.image = seletedSpotsImage[indexPath.row]

            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteSeletedSpot(sender:)), for: .touchUpInside)
            
            cell.spotName.text = selectedSpots[indexPath.row].title
            
            return cell
        case searchResultCollectionView:
            let cell: TravelSpotCell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVIdentifier, for: indexPath) as! TravelSpotCell
            
            searchResultImage.append(UIImage(named: "full_placeholder")!)

            cell.spotImage.image = searchResultImage[indexPath.row]
            cell.spotName.text = searchResult[indexPath.row].title
            
            if searchResult[indexPath.row].category1?.code == CourseCategoryCode{
                cell.backgroundColor = UIColor.gray
            } else{
                cell.backgroundColor = UIColor.white
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
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempSpot = selectedSpots.remove(at: sourceIndexPath.item)
        selectedSpots.insert(tempSpot, at: destinationIndexPath.item)
        
        let tempImage = seletedSpotsImage.remove(at: sourceIndexPath.item)
        seletedSpotsImage.insert(tempImage, at: destinationIndexPath.item)
        
        let tempMarker = markers.remove(at: sourceIndexPath.item)
        markers.insert(tempMarker, at: destinationIndexPath.item)
        
        let tempPath = path.removeCoordinate(at: UInt(sourceIndexPath.item))
        path.insert(tempMarker.position, at: UInt(destinationIndexPath.item))
        
        mapPolylineUpdateByPath(path: path)
    }
    
    func deleteSeletedSpot(sender: UIButton){
        print("seleted")
        
        selectedSpots.remove(at: sender.tag)
        seletedSpotsImage.remove(at: sender.tag)
        
        markers[sender.tag].map = nil
        markers.remove(at: sender.tag)
        path.removeCoordinate(at: UInt(sender.tag))
        
        mapPolylineUpdateByPath(path: path)
        SelectedSpotsCollectionView.reloadData()
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        if editMode == false { return }
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let seletedIndexPath = self.SelectedSpotsCollectionView.indexPathForItem(at: gesture.location(in: self.SelectedSpotsCollectionView)) else { break }
            SelectedSpotsCollectionView.beginInteractiveMovementForItem(at: seletedIndexPath)
        case UIGestureRecognizerState.changed:
            SelectedSpotsCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            SelectedSpotsCollectionView.endInteractiveMovement()
        default:
            SelectedSpotsCollectionView.cancelInteractiveMovement()
        }
    }
}
