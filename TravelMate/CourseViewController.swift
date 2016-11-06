//
//  CourseViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    var courses: [CourseModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: "서울", completion: {
                spots in
                var course: CourseModel!
                for (index, spot) in spots.enumerated() {
                    if index % 5 == 0 {
                        course = CourseModel(title: spot.title, content: "dfjlaksdjlfkjsaledkfjalksdjclksjfkladjsklfjsakldjfkladjsflkajsdlfkjaklsfjlkdjsalfkjsdlkfjaksldjflkasjdfklajskldfjaskldjfaklsjdfklasjdfkl", authorId: "123456", authorName: "이동규", spots: [], createdAt: Int(Date().timeIntervalSince1970), status: .active)
                        self.courses.append(course)
                    }
                    course.spots.append(spot)
                }
                self.tableView.reloadData()
            })
        #endif
        
        self.tableView.register(UINib(nibName: "CourseTimelineCell", bundle: nil), forCellReuseIdentifier: "CourseTimelineCell")
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTimelineCell") as? CourseTimelineCell
        
        guard let courseCell = cell else {
            return UITableViewCell()
        }
        
        let course = courses[indexPath.row]
        courseCell.course = course
        courseCell.titleLabel.text = course.title
        courseCell.createdAtLabel.text = Date(timeIntervalSince1970: Double(course.createdAt!)).description
        courseCell.statusLabel.text = course.status.getText()
        courseCell.statusLabel.textColor = course.status.getColor()
        return courseCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Course", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailCourseViewController") as? DetailCourseViewController
        
        if let detailViewController = vc {
            detailViewController.course = self.courses[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
