//
//  CourseTimelineCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CourseTimelineCell: UITableViewCell {

    var course: CourseModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var routeView: RouteView!
    
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
        
        createdAtLabel.text = Date(timeIntervalSince1970: Double(createdAt)).description
    }
}
