//
//  TouristSite.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SpotModel: Object {
    
    let PROPERTY_TITLE = "title"
    let PROPERTY_CONTENT_ID = "contentid"
    let PROPERTY_CONTENT_TYPE_ID = "contenttypeid"
    let PROPERTY_IMAGE_1 = "firstimage"
    let PROPERTY_IMAGE_2 = "firstimage2"
    let PROPERTY_CATEGORY_1 = "cat1"
    let PROPERTY_CATEGORY_2 = "cat2"
    let PROPERTY_CATEGORY_3 = "cat3"
    let PROPERTY_ADDRESS_1 = "addr1"
    let PROPERTY_ADDRESS_2 = "addr2"
    let PROPERTY_ZIP_CODE = "zipcode"
    let PROPERTY_MAP_X = "mapX"
    let PROPERTY_MAP_Y = "mapY"
    
    
    
    
    // 관광지 이름
    dynamic var title: String!
    
    // 관광지 구분 ID
    dynamic var contentId: String!
    
    // 관광지 타입 ID
    dynamic var contentTypeId: String!
    
    // 대표 이미지 1
    dynamic var titleImage1: String!
    
    // 대표 이미지 2
    dynamic var titleImage2: String!
    
    // 주소
    var address: String! {
        set {
            self.address = "\(self.addr1)\(self.addr2)\(self.zipCode)"
        }
        
        get {
            return "\(self.addr1 == nil ? " ": self.addr1!)\(self.addr2 == nil ? " ": self.addr2!)\(self.zipCode == nil ? "": self.zipCode!)"
        }
    }
    
    // 기본 주소
    dynamic var addr1: String!
    
    // 상세 주소
    dynamic var addr2: String!
    
    // 우편 번호
    dynamic var zipCode: String!
    
    // 대분류
    dynamic var category1: CategoryModel?
    
    // 중분류
    dynamic var category2: CategoryModel?
    
    // 소분류
    dynamic var category3: CategoryModel?
    
    // x좌표
    dynamic var x = 0.0
    
    // y좌표
    dynamic var y = 0.0
    
    
    func setData(dict: [String: Any]) {
        let dbManager = DBManager()
        
        if dict[PROPERTY_TITLE] != nil {
            title = dict[PROPERTY_TITLE] as! String
        }
        
        if dict[PROPERTY_CONTENT_ID] != nil {
            contentId = dict[PROPERTY_CONTENT_ID] as! String
        }
        
        if dict[PROPERTY_CONTENT_TYPE_ID] != nil {
            contentTypeId = dict[PROPERTY_CONTENT_TYPE_ID] as! String
        }
        
        if dict[PROPERTY_IMAGE_1] != nil {
            titleImage1 = dict[PROPERTY_IMAGE_1] as! String
        }
        
        if dict[PROPERTY_IMAGE_2] != nil {
            titleImage2 = dict[PROPERTY_IMAGE_2] as! String
        }
        
        if dict[PROPERTY_ADDRESS_1] != nil {
            addr1 = dict[PROPERTY_ADDRESS_1] as! String
        }
        
        if dict[PROPERTY_ADDRESS_2] != nil {
            addr2 = dict[PROPERTY_ADDRESS_2] as! String
        }
        
        if dict[PROPERTY_ZIP_CODE] != nil {
            zipCode = dict[PROPERTY_ZIP_CODE] as! String
        }
        
        if dict[PROPERTY_CATEGORY_1] != nil {
            let category = dict[PROPERTY_CATEGORY_1] as! String
            category1 = CategoryModel()
            category1?.code = category
            category1?.name = dbManager.categoryName(categoryCode: category)
        }
        
        if dict[PROPERTY_CATEGORY_2] != nil {
            let category = dict[PROPERTY_CATEGORY_2] as! String
            category2 = CategoryModel()
            category2?.code = category
            category2?.name = dbManager.categoryName(categoryCode: category)
        }
        
        if dict[PROPERTY_CATEGORY_3] != nil {
            let category = dict[PROPERTY_CATEGORY_3] as! String
            category3 = CategoryModel()
            category3?.code = category
            category3?.name = dbManager.categoryName(categoryCode: category)
        }
        
        if dict[PROPERTY_MAP_X] != nil {
            x = dict[PROPERTY_MAP_X] as! Double
        }
        
        if dict[PROPERTY_MAP_Y] != nil {
            y = dict[PROPERTY_MAP_Y] as! Double
        }
    }
    
    func toString() -> String {
        return "title = \(self.title), contentId = \(self.contentId), contentTypeId = \(self.contentTypeId), titleImage1 = \(self.titleImage1), titleImage2 = \(self.titleImage2), address = \(self.address), category1 = \(self.category1?.name), category2 = \(self.category2?.name), category3 = \(self.category3?.name), x = \(self.x), y = \(self.y)"
    }
}
