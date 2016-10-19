//
//  MainMenuController.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 10. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainMenuController: UITabBarController{
    let win: UIWindow = ((UIApplication.shared.delegate?.window)!)!
    let writeBtn: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWriteBtn()
    }
    
    func addWriteBtn(){
        let writeBtnImage = UIImage(named: "ic_add_circle_36pt")
        
        writeBtn.frame = CGRect(x: 0.0, y: win.frame.size.height - 42, width: 42, height: 42)
        writeBtn.center = CGPoint(x: win.center.x, y: writeBtn.center.y)
        writeBtn.setBackgroundImage(writeBtnImage, for: .normal)
        win.addSubview(writeBtn)
        
        writeBtn.addTarget(self, action: #selector(doWrite(sender:)), for: .touchUpInside)
    }
    
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
            let writeMenuController = mainStoryBoard.instantiateViewController(withIdentifier: "writemenu") as! UIViewController
            
            // make modalview background color 'transparent'
            writeMenuController.providesPresentationContextTransitionStyle = true
            writeMenuController.definesPresentationContext = true
            writeMenuController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
            self.navigationController?.present(writeMenuController, animated: true, completion: nil)
         
        } else{
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
