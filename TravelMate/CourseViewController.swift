//
//  CourseViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var courses: [CourseModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "CourseTimelineCell", bundle: nil), forCellReuseIdentifier: "CourseTimelineCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: "서울", completion: {
                spots in
                var course: CourseModel!
                for (index, spot) in spots.enumerated() {
                    if index % 6 == 0 {
                        course = CourseModel(title: spot.title, description: spot.description, authorId: "123456", authorName: "이동규", spots: [], createdAt: Int(Date().timeIntervalSince1970))
                        self.courses.append(course)
                    }
                    course.spots.append(spot)
                }
                self.tableView.reloadData()
            })
        #endif
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTimelineCell") as? CourseTimelineCell
        guard let courseCell = cell else {
            return UITableViewCell()
        }
        
        let course = courses[indexPath.row]
        courseCell.course = course
        courseCell.titleLabel.text = course.title
        courseCell.routeView.spots = course.spots
        courseCell.createdAtLabel.text = Date(timeIntervalSince1970: Double(course.createdAt!)).description
        return courseCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
}
