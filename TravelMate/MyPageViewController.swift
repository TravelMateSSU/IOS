//
//  MyPageViewController.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var courses: [CourseModel] = []
    var user: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()

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
            
            user = UserModel()
            user.id = "123456"
            user.name = "이동규"
        #endif
        
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}


extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        
        tableView.register(UINib(nibName: "CourseTimelineCell", bundle: nil), forCellReuseIdentifier: "CourseTimelineCell")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75;
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "프로필"
        }
        
        else if section == 1 {
            return "공유 글"
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 프로필
        if section == 0 {
            return 1
        }
        
        // 공유 글
        else if section == 1 {
            return courses.count;
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 프로필
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileCell
            
            guard let profileCell = cell else {
                return UITableViewCell()
            }
            
            profileCell.idLabel.text = user.id
            profileCell.nameLabel.text = user.name
            // TODO: 프로필 이미지 출력
            return profileCell
        }
        
        // 공유 글
        else if indexPath.section == 1 {
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
        return UITableViewCell()
    }
}
