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
    
    let errorDict = [200: "success", -1: "Response Json 데이터 없음"]
    public let BASE_URL = "http://52.207.208.49:7777/"
    
    
    // 서버에서 후기 타임라인 리스트 load
    func loadEpilogueTimeline(time: Date, loadMoreCount: Int, _ completion : @escaping ([EpilogueModel]?, Int) -> Void) {
        let parameters: Parameters = ["time": time, "offset": loadMoreCount, "limit": 20]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                var epilogues: [EpilogueModel] = []
                guard let epilogueJSONs = JSON["epilogues"] as? [[String: AnyObject]] else {
                    print("No EpilogueJSONs")
                    return
                }
                for epilogueJSON in epilogueJSONs {
                    let epilogue = EpilogueModel(json: epilogueJSON)
                    epilogues.append(epilogue)
                }
                
                completion(epilogues, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에서 코스 타임라인 리스트 load
    func loadCourseTimeline(time: Date, loadMoreCount: Int, _ completion : @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["offset": loadMoreCount, "limit": 20, "status": -1]
        Alamofire.request(BASE_URL + "event/list", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            if let result = response.result.value as? [String: Any] {
                guard let courseJSONs = result["events_list"] as? [[String: Any]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                var courses: [CourseModel] = []
                
                for courseJSON in courseJSONs {
                    let course = CourseModel(courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            }
        }
    }
    
    // 서버에서 키워드로 검색결과(타임라인) 요청
    func loadCourseTimelineByKeyword(keyword: String, time: Date, loadMoreCount: Int, _ completion : @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["hash_tag":keyword, "offset": loadMoreCount, "limit": 20, "status": 3]
        Alamofire.request(BASE_URL + "event/list", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            if let result = response.result.value as? [String: Any] {
                guard let courseJSONs = result["events_list"] as? [[String: Any]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                var courses: [CourseModel] = []
                
                for courseJSON in courseJSONs {
                    let course = CourseModel(courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            }
        }
    }
    
    
    // 서버에 후기 작성 데이터 전송
    func requestEpilogueInsertion(epilogue: EpilogueModel, _ completion: @escaping (Int) -> Void) {
        let parameters: Parameters = ["epilogue": epilogue]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                completion(200)
            } else {
                print("fail")
                completion(300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 코스 구독 정보 전송
    func sendCourseSubscription(courseId: String) {
        let parameters: Parameters = ["course_id": courseId]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            
        }
    }
    
    
    // 서버에 코스 참가 의사 정보 전송
    func requestJoinInCourseInfo(courseId: String, userId: String, isJoin: Bool, _ completion: @escaping (Int) -> Void) {
        let parameters: Parameters = ["course_id": courseId, "user_id": userId, "is_join": isJoin]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                completion(200)
            } else {
                print("fail")
                completion(300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 코스 키워드 검색 요청
    func loadSpotsByKeyword(keyword: String, _ completion: @escaping ([SpotModel]?, Int) -> Void) {
        let parameters: Parameters = ["keyword": keyword]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                var spots: [SpotModel] = []
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                
                guard let spotJSONs = JSON["courses"] as? [[String: AnyObject]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                
                for spotJSON in spotJSONs {
                    let spot = SpotModel()
                    //                        spot.setDa
                    spots.append(spot)
                }
                
                completion(spots, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 코스 키워드 검색 요청
    func loadCourseByKeyword(keyword: String, _ completion: @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["keyword": keyword]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                var courses: [CourseModel] = []
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                
                guard let courseJSONs = JSON["courses"] as? [[String: AnyObject]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                
                for courseJSON in courseJSONs {
                    let course = CourseModel(courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 검색 Spot을 포함하는 Course 요청
    func loadCourseBySpot(spotId: String, _ completion: @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["spotId": spotId]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                var courses: [CourseModel] = []
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                
                guard let courseJSONs = JSON["courses"] as? [[String: AnyObject]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                
                for courseJSON in courseJSONs {
                    let course = CourseModel(courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 특정 Course의 후기글 요청
    func loadEpilogueinCourse(courseId: Int, _ completion: @escaping ([EpilogueModel]?, Int) -> Void) {
        let parameters: Parameters = ["courseId": courseId]
        Alamofire.request(BASE_URL, method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                var epilogues: [EpilogueModel] = []
                guard let epilogueJSONs = JSON["epilogues"] as? [[String: AnyObject]] else {
                    print("No EpilogueJSONs")
                    return
                }
                for epilogueJSON in epilogueJSONs {
                    let epilogue = EpilogueModel(json: epilogueJSON)
                    epilogues.append(epilogue)
                }
                
                completion(epilogues, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 글 공유 요청
    func requestShareCourse(user: UserInfoModel, course: CourseModel, _ completion: @escaping (Int) -> Void) {
        let parameters: Parameters = ["user_id": user.id, "event_id": course.id]
        Alamofire.request(BASE_URL + "event/list", method: .post, parameters: parameters).responseJSON(completionHandler: {
            response in
            if response.result.isSuccess {
                completion(200)
            } else {
                completion(300/*result Code*/)
            }
        })
    }
    
    
    // 서버에서 유저가 공유한 글 리스트 받아오기
    func loadUsersSharedCourses(user: UserInfoModel, _ completion: @escaping (([CourseModel]?, Int) -> Void)) {
        let parameters: Parameters = ["status": 2, "user_id": user.id]
        Alamofire.request(BASE_URL + "event/list", method: .post, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                var courses: [CourseModel] = []
                guard let JSON = response.result.value as? [String: AnyObject] else {
                    print("No Json Data")
                    completion(nil, -1)
                    return
                }
                
                guard let courseJSONs = JSON["courses"] as? [[String: AnyObject]] else {
                    print("No courses JSON")
                    completion(nil, -1)
                    return
                }
                
                for courseJSON in courseJSONs {
                    let course = CourseModel(courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    func insertRecruting(course: CourseModel, _ handler: @escaping (Bool, Int) -> Void){

        //let urlString = "http://52.207.208.49:7777/echo"
        let urlString = "http://52.207.208.49:7777/event/enroll"
        
        var spotList = [[String:Any]]()
        for spot in course.spots{
            let content_id = spot.contentId!
            let content_type = spot.contentTypeId!
            guard var sequence_id = course.spots.index(of: spot) else { return }
            sequence_id += 1
            var image_url: String! = "bagic"
            if spot.titleImage1 != nil { image_url = spot.titleImage1 }
            course.hashTag.append("#\(spot.title!)")
            
            let spot = ["content_id": content_id, "sequence_id": sequence_id, "content_type": content_type, "image_url": image_url] as [String : Any]
            spotList.append(spot)
        }
        
        let requestParsams = ["user_id":course.author.id,
                             "title":course.title,
                             "description":course.content,
                             "course_list":spotList,
                             "max_tourist":course.maxCompanionNum,
                             "start_time":course.travelStartDate,
                             "end_time":course.travelEndDate,
                             "event_end_time":course.recruitEndDate,
                             "hash_tag":course.hashTag] as [String : Any]
        
        Alamofire.request(urlString, method: .post, parameters: requestParsams, encoding: JSONEncoding.default, headers: [:])
            .responseJSON{ response in
                if let receive = response.result.value as? [String: AnyObject]{
                    print("myreceive: \(receive)")
                    handler(false, 200)
                } else{
                    handler(true, 200)
                }
        }
    }
    
    func requestLoginAndJoin(isJoin: Bool,userInfo: UserInfoModel, _ handler: @escaping (Bool, Int) -> Void){
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
