//
//  MainMenuController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainMenuController: UITabBarController {
    let win: UIWindow = ((UIApplication.shared.delegate?.window)!)!
    var writeBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        createWriteBtn()
        addWriteBtn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeWriteBtn()
    }
    
    func createWriteBtn(){
        let writeBtnImage = UIImage(named: "ic_add_circle_36pt")
        
        writeBtn = UIButton(type: .custom)
        writeBtn.frame = CGRect(x: 0.0, y: win.frame.size.height - 50, width: 42, height: 42)
        writeBtn.center = CGPoint(x: win.center.x, y: writeBtn.center.y)
        writeBtn.setBackgroundImage(writeBtnImage, for: .normal)
        
        writeBtn.addTarget(self, action: #selector(doWrite(sender:)), for: .touchUpInside)
    }
    
    func searchCancel() {
        self.view.endEditing(true)
    }

    func addWriteBtn(){
        writeBtn.transform = CGAffineTransform.identity
        win.addSubview(writeBtn)
        win.updateFocusIfNeeded()
    }
    
    func removeWriteBtn(){
        writeBtn.removeFromSuperview()
    }
    
    // WriteBtn 클릭 이벤트 - btn animation, presentWriteMenu
    func doWrite(sender: UIButton!){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let identity = sender.transform.isIdentity
            
            self.presentWriteMenu(identity: identity)
            
            if identity {
                let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI/4))
                
                sender.transform = rotationTransform
                sender.bounds = CGRect(x: 0, y: 0, width: sender.bounds.size.width, height: sender.bounds.size.height)
            } else {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
    func presentWriteMenu(identity: Bool){
        
        if identity {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let writeMenuController = mainStoryBoard.instantiateViewController(withIdentifier: "writemenu") 
            
            // make modalview background color 'transparent'
            writeMenuController.providesPresentationContextTransitionStyle = true
            writeMenuController.definesPresentationContext = true
            writeMenuController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
 
            self.navigationController?.present(writeMenuController, animated: true, completion: nil)

        } else{
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doLogout(_ sender: AnyObject) {
        KOSession.shared().logoutAndClose{ success, error in
            if success{
                print("로그아웃 성공")
            } else{
                print("로그아웃 실패 \(error)")
            }
        }
    }
}
