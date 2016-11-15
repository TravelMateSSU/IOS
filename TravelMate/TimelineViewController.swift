//
//  TimelineViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITabBarDelegate {

    @IBOutlet var tabBar: UITabBar!
    
    @IBOutlet var courseTabBarItem: UITabBarItem!
    
    @IBOutlet var epilogueTabBarItem: UITabBarItem!
    
    @IBOutlet var epilogueView: UIView!
    
    @IBOutlet var courseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
        tabBar.selectedItem = courseTabBarItem
        epilogueView.isHidden = true
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.isEqual(courseTabBarItem) {
            // 코스 탭바 클릭
            courseView.isHidden = false
            epilogueView.isHidden = true
        } else if item.isEqual(epilogueTabBarItem) {
            // 후기 탭바 클릭
            courseView.isHidden = true
            epilogueView.isHidden = false
        }
    }
}
