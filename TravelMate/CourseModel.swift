//
//  CourseModel.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

enum CourseStatus {
    case active
    case deactive
    case suspension
    
    func getText() -> String? {
        if self == .active {
            return "모집 중"
        } else if self == .deactive {
            return "모집 종료"
        } else if self == .suspension {
            return "보류"
        }
        return nil
    }
    
    func getColor() -> UIColor? {
        if self == .active {
            return UIColor.blue
        } else if self == .deactive {
            return UIColor.red
        } else if self == .suspension {
            return UIColor.orange
        }
        return nil
    }
}

class CourseModel {
    var id: Int!
    var authorId: String!
    var authorName: String
    var title: String!
    var content: String!
    var createdAt: Int!
    var spots: [SpotModel] = []
    var titleImage: UIImage!
    var status: CourseStatus!
    
    init(title: String, content: String, authorId: String, authorName: String, spots: [SpotModel], createdAt: Int, status: CourseStatus) {
        self.title = title
        self.content = content
        self.authorName = authorName
        self.authorId = authorId
        self.spots = spots
        self.createdAt = createdAt
        self.status = status
    }
}
