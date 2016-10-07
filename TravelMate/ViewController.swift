//
//  ViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 9. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TourAPIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dBManager = DBManager()
        let isBeginner = UserDefaults.standard.value(forKey: "isBeginner")
        if isBeginner == nil {          // 처음 앱을 시작한 사람
            // 카테고리 SQLite -> Realm DB화
            dBManager.copyCategories()
            
            UserDefaults.standard.set(1, forKey: "isBeginner")
        } else {
            dBManager.categoriesDict()
        }
        
        
//        let routeView = RouteView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
//        routeView.append(title: "실험1")
//        routeView.append(title: "실험2")
//        routeView.append(title: "실험3")
//        routeView.append(title: "실험4")
//        routeView.append(title: "실험5")
//        routeView.append(title: "실험6")
//        self.view.addSubview(routeView)
//        routeView.setNeedsDisplay()
        
        let apiManager = TourAPIManager()
        let touristSite = Tourist()
        touristSite.contentTypeId = "12"
        touristSite.contentId = "636266"
        apiManager.delegate = self
        try! apiManager.querySearchById(tourist: touristSite)
    }

    func searchById(tourist: Tourist) {
        print(tourist.toString())
    }

    func searchByIdFailed() {
        
    }
    
    
    func searchByKeyword(touristList: [Tourist]) {
        print("Success")
        touristList.map({
            tourist in
            print(tourist.toString())
        })
    }
    
    func searchByKeywordFailed() {
        
    }
    
}

