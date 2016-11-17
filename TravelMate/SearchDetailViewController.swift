//
//  SearchDetailViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    let networkManager = NetworkManager()
    var spot: SpotModel!
    var keyword: String!
    
    var courses: [CourseModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSubView()
    }
    
    func createSubView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
     
        tableView.register(UINib(nibName: "CourseTimelineCell", bundle: nil), forCellReuseIdentifier: "CourseTimelineCell")
        
        networkManager.loadCourseTimelineByKeyword(keyword: self.keyword, time: Date(), loadMoreCount: 0, {
            courses, code in
            if code == 200 {
                print("성공")
                self.courses = courses!
                self.tableView.reloadData()
            } else {
                print("실패")
            }
        })
        
    }
}


extension SearchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTimelineCell") as? CourseTimelineCell

        guard let courseCell = cell else {
            return UITableViewCell()
        }
        
        let course = courses[indexPath.row]
        courseCell.course = course
        courseCell.titleLabel.text = course.title
        courseCell.createdAtLabel.text = course.createdAt.description
        courseCell.statusLabel.text = course.status.getText()
        courseCell.statusLabel.textColor = course.status.getColor()
        return courseCell
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
