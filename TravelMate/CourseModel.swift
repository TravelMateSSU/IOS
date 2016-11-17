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
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .active
        default:
            self = .deactive
        }
    }
}

class CourseModel {
    var id: Int!
    var author = UserInfoModel()
    var title: String!
    var content: String!
    var createdAt: Date!
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
    
    init(_ json: [String: Any]) {
        if let id = json["event_id"] {
            self.id = id as? Int
        }
        
        if let user = json["user"] {
            let userJSON = user as? [String: AnyObject]
            self.author = UserInfoModel(userJSON!)
        } else if let userId = json["user_id"] {
            self.author.id = userId as? String
        }
        
        if let title = json["title"] {
            self.title = title as? String
        }
        
        if let description = json["description"] {
            self.content = description as? String
        }
        
        if let maxCompanionNum = json["max_tourist"] {
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
            let statusInt = status as? Int
            self.status = CourseStatus(rawValue: statusInt!)
        }
        
        if let createdAt = json["created"] {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZZ"
            self.createdAt = dateFormatter.date(from: createdAt as! String)
        }
        
        if let hashTag = json["hash_tag"] {
            if let hashTag = hashTag as? String {
                self.hashTag = hashTag
                let spotTitles = hashTag.components(separatedBy: "#")
                for i in 1 ..< spotTitles.count {
                    let spot = SpotModel()
                    let spotTitle = spotTitles[i]
                    spot.title = spotTitle
                    self.spots.append(spot)
                }
                
                // 해시태그 없을 때 빈 데이터 삽입
                if spotTitles.count == 1 {
                    self.hashTag = ""
                    let spot = SpotModel()
                    spot.title = ""
                    self.spots.append(spot)
                }
            }
            
            // 해시태그 없을 때 빈 데이터 삽입
            else {
                self.hashTag = ""
                let spot = SpotModel()
                spot.title = ""
                self.spots.append(spot)
            }
        }
        
    }

}
