//
//  WriteEpilogueTableViewCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteEpilogueCollectionViewCell: UICollectionViewCell {

    @IBOutlet var removableImageView: RemovableImageView!
    
    var delegate: RemovableDelegate? {
        willSet(delegate) {
            self.removableImageView.delegate = delegate
        }
    }
}
