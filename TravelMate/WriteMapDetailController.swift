//
//  WriteMapDetailController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 11. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteMapDetailController: UIViewController {
    @IBOutlet weak var writeView: WriteMapDetailView!
    
    var spots: [SpotModel]!
    
    override func viewWillAppear(_ animated: Bool) {
        writeView.enrollButton.addTarget(self, action: #selector(networkTest(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func networkTest(_ sender: AnyObject) {
        guard let title = writeView.titleText.text else { return }
        guard let content = writeView.descriptionText.text else { return }
        let authorId = "123456789"
        let authorName = "ppang"
        let hashTag = "abc"
        guard let travelStartDay = writeView.travelStartDay.text else { return }
        guard let travelEndDay = writeView.travelEndDay.text else { return }
        guard let recuritEndDay = writeView.RecruitEndDay.text else { return }
        guard let maxPeople = Int(writeView.maxPeople.text!) else { return }
        
        let user = UserInfoModel()
        user.id = authorId
        user.nickName = authorName
        var course = CourseModel(title: title, content: content, author: user, spots: spots, maxCompanionNum: maxPeople, travelEndDate: travelEndDay, travelStartDate: travelStartDay, recruitEndDate: recuritEndDay, hashTag: hashTag)
        
        let networkManager = NetworkManager()
        networkManager.insertRecruting(course: course) { (err, code) in
            if err {
                // 실패
                print("실패")
            } else {
                // 성공
                print("success")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
