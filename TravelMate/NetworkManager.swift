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
    
    public let BASE_URL = "http://url.com/"
    
    func insertEpilogue(epilogue: EpilogueModel, _ handler: (Bool, Int) -> Void) {
        handler(false, 200)
    }
    
    
    // 서버에서 유저가 공유한 글 리스트 받아오기
    func loadUsersSharedCourses(user: UserModel, _ complition: (([CourseModel]) -> Void)) {
        Alamofire.request(BASE_URL /* + URL */).responseJSON(completionHandler: {
            response in
            print(response.request)
            print(response.response)
            print(response.data)
            print(response.result)
        })
    }
}
