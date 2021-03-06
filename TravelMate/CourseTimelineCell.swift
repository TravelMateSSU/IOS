//
//  CourseTimelineCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CourseTimelineCell: UITableViewCell {

    var course: CourseModel! {
        willSet (setValue) {
            routeView.spots = setValue.spots
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var routeView: RouteView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let course = self.course else {
            return
        }
        
        titleLabel.text = course.title
        routeView.spots = course.spots
        
        guard let createdAt = course.createdAt else {
            return
        }
        
        createdAtLabel.text = course.createdAt.description
        
        statusLabel.text = course.status.getText()
        statusLabel.textColor = course.status.getColor()
    }
}
