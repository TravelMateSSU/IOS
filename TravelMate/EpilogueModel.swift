//
//  EpilogueModel.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 29..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class EpilogueModel {
    var id = 0
    var author: UserInfoModel!
    var createdAt: Int!
    var contents: String!
    var images = [UIImage]()
    
    
    init() {
        
    }
    
    init(json: [String: AnyObject]) {
        
    }
}
