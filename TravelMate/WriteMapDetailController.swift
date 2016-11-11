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
        let networkManager = NetworkManager()
        networkManager.insertRecruting() { (err, code) in
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
