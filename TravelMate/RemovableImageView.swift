//
//  RemovableImageView.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

public protocol RemovableDelegate: class {
    func removeImagePressed()
}

class RemovableImageView: UIView {
    
    var delegate: RemovableDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        willSet(image) {
            imageView.image = image
        }
    }

    @IBAction func removeImagePressed(_ sender: AnyObject) {
        self.isHidden = true
        if let delegate = self.delegate {
            delegate.removeImagePressed()
            
        } else {
            print("Error! Please regist RemovableDelegate to RemovableImageView")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    fileprivate func setup() {
        let view = loadFromNib()
        addSubview(view)
        
        view.frame = bounds
    }
    
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "RemovableImageView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view!
    }

}
