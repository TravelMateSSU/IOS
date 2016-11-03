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
    
    var path: GMSMutablePath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
