//
//  WriteMenuController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteMenuController: UIViewController {

    
    
    @IBAction func writeEpiloguePressed(_ sender: UIButton) {
        // WriteEpilogue Storyboard를 띄워줍니다.
        let storyboard = UIStoryboard(name: "WriteEpilogue", bundle: nil)
        let writeEpilogueNavigationController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
        
        self.present(writeEpilogueNavigationController, animated: true, completion: nil)
    }
    
}
