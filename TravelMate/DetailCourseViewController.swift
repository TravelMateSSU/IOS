//
//  DetailEpilogueViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class DetailCourseViewController: UIViewController {

    var course: CourseModel!
    
    var epilogues: [EpilogueModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubView()
    }
    
    func addSubView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "CourseTimelineCell", bundle: nil), forCellReuseIdentifier: "CourseTimelineCell")
        
        tableView.register(UINib(nibName: "EpilogueTimelineCell", bundle: nil), forCellReuseIdentifier: "EpilogueTimelineCell")
        
        #if DEBUG
            let epilogue = EpilogueModel()
            epilogue.id = 1
            epilogue.authorId = "123456"
            epilogue.authorName = "이동규"
            epilogue.description = "내용"
            epilogue.createdAt = Int(Date().timeIntervalSince1970)
            self.epilogues.append(epilogue)
        #endif
    }
}

extension DetailCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "코스"
        } else if section == 1 {
            return "후기"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 코스 자체 정보
        if section == 0 {
            return 1
        }
            
        // 코스에 대한 후기
        else if section == 1 {
            return epilogues.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 코스 자체 정보
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTimelineCell") as? CourseTimelineCell
            
            guard let courseCell = cell else {
                return UITableViewCell()
            }
            
            courseCell.course = self.course
            courseCell.titleLabel.text = course.title
            courseCell.descriptionLabel.text = course.content
            courseCell.createdAtLabel.text = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(course.createdAt))).description
            courseCell.statusLabel.text = course.status.getText()
            courseCell.statusLabel.textColor = course.status.getColor()
            return courseCell
        }
        
        // 코스에 대한 후기
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpilogueTimelineCell") as? EpilogueTimelineCell
            
            guard let epilogueCell = cell else {
                return UITableViewCell()
            }
            
            let epilogue = epilogues[indexPath.row]
            epilogueCell.epilogue = epilogue
            epilogueCell.nameLabel.text = epilogue.authorName
            epilogueCell.createdAtLabel.text = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(epilogue.createdAt))).description
            epilogueCell.descriptionLabel.text = epilogue.description
            return epilogueCell
        }
        
        return UITableViewCell()
    }
}
