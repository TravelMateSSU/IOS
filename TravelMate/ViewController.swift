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
        
        let routeView = RouteView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        routeView.append(title: "실험1")
        routeView.append(title: "실험2")
        routeView.append(title: "실험3")
        routeView.append(title: "실험4")
        routeView.append(title: "실험5")
        routeView.append(title: "실험6")
        self.view.addSubview(routeView)
        routeView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

