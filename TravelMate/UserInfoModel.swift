//
//  UserInfoModel.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 11. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class UserInfoModel: NSObject, NSCoding {
    var id: String!
    var nickName: String!
    var profileImageURL: String!
    var thumbnailImageURL: String!
    
    init(id: String, nickName: String, profileImageURL: String, thumbnailImageURL: String) {
        self.id = id
        self.nickName = nickName
        self.profileImageURL = profileImageURL
        self.thumbnailImageURL = thumbnailImageURL
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let nickName = aDecoder.decodeObject(forKey: "nickName") as! String
        let profileImageURL = aDecoder.decodeObject(forKey: "profileImageURL") as! String
        let thumbnailImageURL = aDecoder.decodeObject(forKey: "thumbnailImageURL") as! String
        self.init(id: id, nickName: nickName, profileImageURL: profileImageURL, thumbnailImageURL: thumbnailImageURL)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(profileImageURL, forKey: "profileImageURL")
        aCoder.encode(thumbnailImageURL, forKey: "thumbnailImageURL")
    }
    
    func toString() -> String{
        return "id: \(id) nickName: \(nickName) profileImageURL: \(profileImageURL) thumbnailImageURL: \(thumbnailImageURL)"
    }
}

