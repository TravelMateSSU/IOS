//
//  WriteMapDetailView.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 11. 10..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteMapDetailView: UIView {
    @IBOutlet weak var enrollButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitialization()
    }
    
    func commonInitialization(){
        let view = Bundle.main.loadNibNamed("WriteMapDetailView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func tapGestureAction(_ sender: AnyObject) {
        self.endEditing(true)
    }
}
