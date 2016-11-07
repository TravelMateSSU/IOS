//
//  SearchPreviewCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchPreviewCell: UITableViewCell {

    var spot: SpotModel!
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let spot = self.spot else {
            return
        }
        
        titleLabel.text = spot.title
        // TODO : 이미지 띄워주기
//        titleImageView.image = spot.titleImage1
    }
}
