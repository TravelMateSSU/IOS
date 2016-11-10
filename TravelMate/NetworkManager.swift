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
    
    
    // 서버에서 후기 타임라인 리스트 load
    func loadEpilogueTimeline(time: Date, _ completion : @escaping ([EpilogueModel], TourError) -> Void) {
        let parameters: Parameters = ["time": time]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    
    // 서버에서 코스 타임라인 리스트 load
    func loadCourseTimeline(time: Date, _ completion : @escaping ([CourseModel], TourError) -> Void) {
        let parameters: Parameters = ["time": time]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    
    // 서버에 후기 작성 데이터 전송
    func sendNewEpilogue(epilogue: EpilogueModel, _ completion: @escaping (TourError) -> Void) {
        let parameters: Parameters = ["epilogue": epilogue]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    
    // 서버에 코스 구독 정보 전송
    func sendCourseSubscription(courseId: String) {
        let parameters: Parameters = ["course_id": courseId]
        Alamofire.request("", parameters: parameters)
    }
    
    
    // 서버에 코스 참가 의사 정보 전송
    func sendJoinInCourseInfo(courseId: String, userId: String, isJoin: Bool, _ completion: (TourError) -> Void) {
        let parameters: Parameters = ["course_id": courseId, "user_id": userId, "is_join": isJoin]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    
    // 서버에 코스 키워드 검색 요청
    func loadCourseByKeyword(keyword: String, _ completion: ([CourseModel], TourError) -> Void) {
        let parameters: Parameters = ["keyword": keyword]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    
    // 서버에 특정 Course의 후기글 요청
    func loadEpilogueinCourse(courseId: String, _ completion: ([EpilogueModel], TourError) -> Void) {
        let parameters: Parameters = ["courseId": courseId]
        Alamofire.request("", parameters: parameters).responseJSON { response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
            
            switch response.result {
            case .success:
                print("success")
                
            case .failure:
                print("fail")
            }
        }
    }
}
