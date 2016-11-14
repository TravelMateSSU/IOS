//
//  NetworkManager.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func insertEpilogue(epilogue: EpilogueModel, _ handler: (Bool, Int) -> Void) {
        handler(false, 200)
    }
    
    func insertRecruting(course: CourseModel, _ handler: @escaping (Bool, Int) -> Void){

        //let urlString = "http://52.207.208.49:7777/echo"
        let urlString = "http://52.207.208.49:7777/event/enroll"
        
        var spotList = [[String:Any]]()
        for spot in course.spots{
            guard let content_id = spot.contentId else { return }
            guard let content_type = spot.contentTypeId else { return }
            guard var sequence_id = course.spots.index(of: spot) else { return }
            sequence_id += 1
            var image_url: String! = "bagic"
            if spot.titleImage1 != nil { image_url = spot.titleImage1 }
            
            let spot = ["content_id": content_id, "sequence_id": sequence_id, "content_type": content_type, "image_url": image_url] as [String : Any]
            spotList.append(spot)
        }
        
        let decoded  = UserDefaults.standard.object(forKey: "UserInfo") as! Data
        let userInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfoModel

        let requestParams = ["user_id":userInfo.id,
                             "title":course.title,
                             "description":course.content,
                             "course_list":spotList,
                             "max_tourist":course.maxPeople,
                             "start_time":course.travelStartDay,
                             "end_time":course.travelEndDay,
                             "event_end_time":course.recuritEndDay,
                             "hash_tag":"abc"] as [String : Any]
        
        Alamofire.request(urlString, method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: [:])
            .responseJSON{ response in
                if let receive = response.result.value as? [String: AnyObject]{
                    print("myreceive: \(receive)")
                    handler(false, 200)
                } else{
                    handler(true, 200)
                }
        }
    }
    
    func tryLoginAndJoin(isJoin: Bool,userInfo: UserInfoModel, _ handler: @escaping (Bool, Int) -> Void){
        let urlString = "http://52.207.208.49:7777/user"
        
        let decoded  = UserDefaults.standard.object(forKey: "UserInfo") as! Data
        let userInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserInfoModel
        
        let requestParams = ["enroll_force":isJoin,
                             "user_id":userInfo.id,
                             "user_name":userInfo.nickName,
                             "profile_url":userInfo.thumbnailImageURL] as [String : Any]
        
        Alamofire.request(urlString, method: .post, parameters: requestParams, encoding: JSONEncoding.default, headers: [:])
            .responseJSON{ response in
                if let receive = response.result.value as? [String: AnyObject]{
                    print("myreceive: \(receive)")
                    
                    handler(false, receive["login"] as! Int)
                } else{
                    handler(true, 200)
                }
        }
    }
}
