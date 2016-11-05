//
//  WriteEpilogueTableViewCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol RemovableCellDelegate {
    func remove(position: Int)
}


class WriteEpilogueCell: UICollectionViewCell, RemovableDelegate {

    @IBOutlet var removableImageView: RemovableImageView!
    
    var position: Int?
    
    var delegate: RemovableCellDelegate?
    
    override func awakeFromNib() {
        removableImageView.delegate = self
    }
    
    func removeImagePressed() {
        guard let delegate = self.delegate else {
            print("Error! Please regist delegate: RemovableCellDelegate in WriteEpilogueCollectionViewCell")
            return
        }
        
        guard let position = self.position else {
            print("Error! Please assign position: in RemovableCellDelegate : WriteEpilogueCollectionViewCell")
            return
        }
        
        delegate.remove(position: position)
    }
}
