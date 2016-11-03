//
//  WriteMenuController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteMenuController: UIViewController{

    @IBAction func doWrite_Map(_ sender: AnyObject) {
        pushWriteMapController()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func pushWriteMapController(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let writeMapController = mainStoryBoard.instantiateViewController(withIdentifier: "writemap") as! UIViewController
        
        let mainViewController = self.presentingViewController as! UINavigationController
        
        mainViewController.pushViewController(writeMapController, animated: true)
    }
}
