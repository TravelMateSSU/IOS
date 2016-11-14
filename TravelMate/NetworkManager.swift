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
        let parameters: Parameters = ["time": time, "loadMoreCount": loadMoreCount]
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
        #if DEBUG
            let tourManager = TourAPIManager()
            tourManager.querySearchByKeyword(keyword: "서울", completion: {
                spots in
                let courses: [CourseModel] = []
                var course: CourseModel!
                for (index, spot) in spots.enumerated() {
                    if index % 5 == 0 {
                        let user = UserModel()
                        user.id = "123456"
                        user.name = "이동규"
                        course = CourseModel(title: spot.title, content: "dfjlaksdjlfkjsaledkfjalksdjclksjfkladjsklfjsakldjfkladjsflkajsdlfkjaklsfjlkdjsalfkjsdlkfjaksldjflkasjdfklajskldfjaskldjfaklsjdfklasjdfkl", author: user, spots: [], createdAt: Int(Date().timeIntervalSince1970), status: .active)
                        courses.append(course)
                    }
                    course.spots.append(spot)
                }
                completion(courses, 200)
            })
        #else
            let parameters: Parameters = ["time": time, "loadMoreCount": loadMoreCount]
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
                        let course = CourseModel(json: courseJSON)
                        courses.append(course)
                    }
                    
                    completion(courses, 200)
                } else {
                    print("fail")
                    completion(nil, 300/*result Code*/)
                }
            }
        #endif
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
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: searchText, completion: {
                spots in
                self.spots = spots
                self.tableView.reloadData()
            })
        #else
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
        #endif
    }
    
    
    // 서버에 코스 키워드 검색 요청
    func loadCourseByKeyword(keyword: String, _ completion: @escaping ([CourseModel]?, Int) -> Void) {
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: searchText, completion: {
                spots in
                self.spots = spots
                self.tableView.reloadData()
            })
        #else
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
                        let course = CourseModel(json: courseJSON)
                        courses.append(course)
                    }
                    
                    completion(courses, 200)
                } else {
                    print("fail")
                    completion(nil, 300/*result Code*/)
                }
            }
        #endif
    }
    
    
    // 서버에 검색 Spot을 포함하는 Course 요청
    func loadCourseBySpot(spotId: String, _ completion: @escaping ([CourseModel]?, Int) -> Void) {
        #if DEBUG
            let manager = TourAPIManager()
            manager.querySearchByKeyword(keyword: searchText, completion: {
                spots in
                self.spots = spots
                self.tableView.reloadData()
            })
        #else
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
                        let course = CourseModel(json: courseJSON)
                        courses.append(course)
                    }
                    
                    completion(courses, 200)
                } else {
                    print("fail")
                    completion(nil, 300/*result Code*/)
                }
            }
        #endif
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
    
    
    // 서버에서 유저가 공유한 글 리스트 받아오기
    func loadUsersSharedCourses(user: UserModel, _ completion: @escaping (([CourseModel]?, Int) -> Void)) {
        Alamofire.request(BASE_URL /* + URL */).responseJSON(completionHandler: {
            response in
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
        })
    }
}
