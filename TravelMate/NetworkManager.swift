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
    
    func insertEpilogue(epilogue: EpilogueModel, _ handler: (Bool, Int) -> Void) {
        handler(false, 200)
    }
    
    
    // 서버에서 후기 타임라인 리스트 load
    func loadEpilogueTimeline(time: Date, _ completion : @escaping ([EpilogueModel]?, Int) -> Void) {
        let parameters: Parameters = ["time": time]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
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
    func loadCourseTimeline(time: Date, _ completion : @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["time": time]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
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
                    let course = CourseModel(json: courseJSON)
                    courses.append(course)
                }
                
                completion(courses, 200)
            } else {
                print("fail")
                completion(nil, 300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 후기 작성 데이터 전송
    func sendNewEpilogue(epilogue: EpilogueModel, _ completion: @escaping (Int) -> Void) {
        let parameters: Parameters = ["epilogue": epilogue]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
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
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
            
        }
    }
    
    
    // 서버에 코스 참가 의사 정보 전송
    func sendJoinInCourseInfo(courseId: String, userId: String, isJoin: Bool, _ completion: @escaping (Int) -> Void) {
        let parameters: Parameters = ["course_id": courseId, "user_id": userId, "is_join": isJoin]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                completion(200)
            } else {
                print("fail")
                completion(300/*result Code*/)
            }
        }
    }
    
    
    // 서버에 코스 키워드 검색 요청
    func loadCourseByKeyword(keyword: String, _ completion: @escaping ([CourseModel]?, Int) -> Void) {
        let parameters: Parameters = ["keyword": keyword]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
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
                    let course = CourseModel(json: courseJSON)
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
    func loadEpilogueinCourse(courseId: String, _ completion: @escaping ([EpilogueModel]?, Int) -> Void) {
        let parameters: Parameters = ["courseId": courseId]
        Alamofire.request("", method: .post, parameters: parameters).responseJSON { response in
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
}
