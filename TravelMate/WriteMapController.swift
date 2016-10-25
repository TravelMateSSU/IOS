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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.5706149055,longitude: 126.9797346814, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(37.5693679015, 126.9838371210)
        marker.title = "가마목"
        marker.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(37.5706149055, 126.9797346814)
        marker2.title = "광화문 미진"
        marker2.map = mapView
        
        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2DMake(37.5655100385, 126.9850482312)
        marker3.title = "나석주의사동상"
        marker3.map = mapView
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2DMake(37.5693679015, 126.9838371210))
        path.add(CLLocationCoordinate2DMake(37.5706149055, 126.9797346814))
        path.add(CLLocationCoordinate2DMake(37.5655100385, 126.9850482312))
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3
        polyline.map = mapView
        
    }
}
