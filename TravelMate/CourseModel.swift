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
    var author: UserModel!
    var title: String!
    var content: String!
    var createdAt: Int!
    var spots: [SpotModel] = []
    var titleImage: UIImage!
    var status: CourseStatus!
    var maxTouristNum: Int!
    var currentTouristNum: Int!
    var travelStartDate: Date!
    var travelEndDate: Date!
    var recruitEndDate: Date!
    
    init(title: String, content: String, authorId: String, authorName: String, spots: [SpotModel], createdAt: Int, status: CourseStatus) {
        self.title = title
        self.content = content
        self.authorName = authorName
        self.authorId = authorId
        self.spots = spots
        self.createdAt = createdAt
        self.status = status
    }
    
    init(json: [String: AnyObject]) {
        if let id = json["event_id"] {
            self.id = id as? Int
        }
        
        if let id = json["user_id"] {
            self.authorId = id as? String
        }
        
        if let title = json["title"] {
            self.title = title as? String
        }
        
        if let description = json["description"] {
            self.content = description as? String
        }
        
        if let maxTouristNum = json["max_tourist"] {
            self.maxTouristNum = maxTouristNum as? Int
        }
        
        if let currentTouristNum = json["current_tourist"] {
            self.currentTouristNum = currentTouristNum as? Int
        }
        
        if let travelStartDate = json["travel_start_time"] {
            self.travelStartDate = travelStartDate as? Date
        }
        
        if let travelEndDate = json["travel_end_time"] {
            self.travelEndDate = travelEndDate as? Date
        }
        
        if let recruitEndDate = json["event_end_time"] {
            self.recruitEndDate = recruitEndDate as? Date
        }
        
        if let status = json["status"] {
            self.status = status as? CourseStatus
        }
        
        if let createdAt = json["created"] {
            self.createdAt = createdAt as? Int
        }
        
        // authorName
        authorName = ""
    }
}
