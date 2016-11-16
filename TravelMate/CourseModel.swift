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
    var author: UserInfoModel!
    var title: String!
    var content: String!
    var createdAt: Int!
    var spots: [SpotModel] = []
    var titleImage: UIImage!
    var status: CourseStatus!
    var maxCompanionNum: Int!
    var currentTouristNum: Int!
    var travelStartDate: String!
    var travelEndDate: String!
    var recruitEndDate: String!
    var hashTag: String!
    
    init(title: String, content: String, author: UserInfoModel, spots: [SpotModel], maxCompanionNum: Int, travelEndDate: String, travelStartDate: String, recruitEndDate: String, hashTag: String){
        self.title = title
        self.content = content
        self.author = author
        self.spots = spots
        self.maxCompanionNum = maxCompanionNum
        self.travelEndDate = travelEndDate
        self.travelStartDate = travelStartDate
        self.recruitEndDate = recruitEndDate
        self.hashTag = hashTag
    }
    
    init(json: [String: AnyObject]) {
        if let id = json["event_id"] {
            self.id = id as? Int
        }
        
        if let user = json["user"] {
            let userJSON = user as? [String: AnyObject]
            self.author = UserInfoModel(userJSON!)
        }
        
        if let title = json["title"] {
            self.title = title as? String
        }
        
        if let description = json["description"] {
            self.content = description as? String
        }
        
        if let maxCompanionNum = json["max_companion"] {
            self.maxCompanionNum = maxCompanionNum as? Int
        }
        
        if let currentTouristNum = json["current_tourist"] {
            self.currentTouristNum = currentTouristNum as? Int
        }
        
        if let travelStartDate = json["travel_start_time"] {
            self.travelStartDate = travelStartDate as? String
        }
        
        if let travelEndDate = json["travel_end_time"] {
            self.travelEndDate = travelEndDate as? String
        }
        
        if let recruitEndDate = json["event_end_time"] {
            self.recruitEndDate = recruitEndDate as? String
        }
        
        if let status = json["status"] {
            self.status = status as? CourseStatus
        }
        
        if let createdAt = json["created"] {
            self.createdAt = createdAt as? Int
        }
        
    }

}
