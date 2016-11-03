//
//  ViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 9. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbManager = DBManager()
        let isBeginner = UserDefaults.standard.value(forKey: "isBeginner")
        if isBeginner == nil {          // 처음 앱을 시작한 사람
            // 카테고리 SQLite -> Realm DB화
            dbManager.copyCategories()
            
            // 앱을 실행했음을 마킹
            UserDefaults.standard.set(1, forKey: "isBeginner")
        }
        
        let category = dbManager.categoriesDict()
        
        
        // 사용법
        /*
        let routeView = RouteView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        routeView.backgroundColor = UIColor.orange
        let tourist = SpotModel()
        tourist.title = "실험"
        routeView.append(spot: tourist)
        routeView.title = "연습타이틀"
        self.view.addSubview(routeView)
        routeView.setNeedsDisplay()
        
        let apiManager = TourAPIManager()
        let spot = SpotModel()
        spot.contentTypeId = "12"
        spot.contentId = "636266"
        apiManager.querySearchByKeyword(keyword: "서울", completion: { spots in
            apiManager.querySearchById(spot: spots[0], completion: {
                spotModel in
                guard let resSpot = spotModel else {
                    return
                }
                
                print(resSpot.title)
            })
        })*/
    }
}

