//
//  CourseModel.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class CourseModel {
    var id: Int!
    var authorId: String!
    var authorName: String
    var title: String!
    var description: String!
    var createdAt: Int!
    var spots: [SpotModel] = []
    var titleImage: UIImage!
    
    init(title: String, description: String, authorId: String, authorName: String, spots: [SpotModel], createdAt: Int) {
        self.title = title
        self.description = description
        self.authorName = authorName
        self.authorId = authorId
        self.spots = spots
        self.createdAt = createdAt
    }
}
