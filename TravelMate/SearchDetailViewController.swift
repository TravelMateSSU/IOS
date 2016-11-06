//
//  SearchDetailViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var spot: SpotModel!
    
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
        
        #if DEBUG
            let course = CourseModel(title: "경복궁", content: "좋았습니다.", authorId: "123456", authorName: "이동규", spots: [spot, spot, spot, spot], createdAt: Int(Date().timeIntervalSince1970), status: .active)
            course.id = 1
            courses.append(course)
            courses.append(course)
            tableView.reloadData()
        #else
            // TODO: courses 데이터 요청
        #endif
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
        courseCell.createdAtLabel.text = Date(timeIntervalSince1970: TimeInterval(Double(course.createdAt))).description
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
