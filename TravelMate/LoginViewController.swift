//
//  LoginViewController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func doKakaoLogin(_ sender: AnyObject) {
        
        let session: KOSession = KOSession.shared()
        
        if session.isOpen(){ // 이미 열린 세션이 있으면 닫는다.
            session.close()
        }
        
        session.presentingViewController = self.navigationController
        session.open(completionHandler: { (error) -> Void in
            session.presentingViewController = nil
            
            if !session.isOpen(){
                print("Kakao Session Close")
            }
            }, authParams: nil, authTypes: [KOAuthType.talk.rawValue, KOAuthType.account.rawValue])
    }
    
    @IBAction func doGuestLogin(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.loadMainViewController()
    }
}
