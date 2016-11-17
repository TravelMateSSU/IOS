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
        writeView.enrollButton.addTarget(self, action: #selector(enrollReview(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enrollReview(_ sender: AnyObject) {
        let decoded  = UserDefaults.standard.object(forKey: "UserInfo") as! Data
        let userInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfoModel
        
        guard let title = writeView.titleText.text else { errorMessage(); return }
        guard let content = writeView.descriptionText.text else { errorMessage(); return }
        let authorId = userInfo.id
        let authorName = userInfo.nickName
        let hashTag = ""
        guard let travelStartDay = writeView.travelStartDay.text else { errorMessage(); return }
        guard let travelEndDay = writeView.travelEndDay.text else { errorMessage(); return }
        guard let recuritEndDay = writeView.RecruitEndDay.text else { errorMessage(); return }
        guard let maxPeople = Int(writeView.maxPeople.text!) else { errorMessage(); return }
        
        let user = UserInfoModel()
        user.id = authorId
        user.nickName = authorName
        var course = CourseModel(title: title, content: content, author: user, spots: spots, maxCompanionNum: maxPeople, travelEndDate: travelEndDay, travelStartDate: travelStartDay, recruitEndDate: recuritEndDay, hashTag: hashTag)
        
        let networkManager = NetworkManager()
        networkManager.insertRecruting(course: course) { (err, code) in
            if err {
                // 실패
                SweetAlert().showAlert(title: "모집글 등록에 실패하였습니다.", subTitle: "다시 시도해주세요(ㅠㅠ)", style: .Error)
            } else {
                // 성공
                SweetAlert().showAlert(title: "모집글이 등록되었습니다!", subTitle: "", style: .Success, buttonTitle: "확인", action: { Void in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
        }
    }
    
    func errorMessage(){
        SweetAlert().showAlert(title: "모집글 등록에 실패하였습니다.", subTitle: "공란없이 모집글을 작성해주세요.", style: .Warning)
    }
}
