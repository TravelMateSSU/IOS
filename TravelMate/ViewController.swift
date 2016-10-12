//
//  ViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 9. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class ViewController: UIViewController, TourAPIDelegate {
    
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
        apiManager.delegate = self
        try! apiManager.querySearchById(spot: spot)
        */
    }

    func searchById(spot: SpotModel) {
        print(spot.toString())
    }

    func searchByIdFailed() {
        
    }
    
    
    func searchByKeyword(spots: [SpotModel]) {
        print("Success")
        spots.map({
            spot in
            print(spot.toString())
        })
    }
    
    func searchByKeywordFailed() {
        
    }
    
=======
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


>>>>>>> 500b791c482d86cc2042ef733fa6db58f7a47032
}

