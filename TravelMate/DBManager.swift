//
//  DBManager.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//

import FMDB
import RealmSwift

class DBManager {
    
    var realm: Realm
    
    
    init() {
        realm = try! Realm()
    }
    
    // 카테고리 DB 복사       sqlite -> realm
    func copyCategories() {
        let resourcePath = Bundle.main.resourceURL!.absoluteString
        let dbPath = resourcePath.appending("travelmate.db")
        let database = FMDatabase(path: dbPath)
        if !(database?.open())! {
            print("db 열기 실패")
        } else {
            print("db 열기 성공")
            if let db = database, let q = db.executeQuery("SELECT * FROM categories;", withArgumentsIn: nil) {
                while q.next() {
                    let code = q.string(forColumn: "CODE")
                    let name = q.string(forColumn: "NAME")
                    
                    if let code = code, let name = name {
                        try! realm.write {
                            let category = CategoryModel()
                            category.code = code
                            category.name = name
                            realm.add(category)
                        }
                    }
                }
            }
        }
    }
    
    
    // 카테고리 코드를 넘겨주면 이름을 리턴
    func categoryName(categoryCode: String) -> String {
        let results = realm.objects(CategoryModel.self).filter(NSPredicate(format: "code = %@", categoryCode))
        if results.isEmpty{
            return "기타"
        }
        return results[0].name
    }
    
    
    // 카테고리 배열 리턴
    func categories() -> [CategoryModel] {
        let results = realm.objects(CategoryModel.self)
        var categories: [CategoryModel] = []
        for i in 0 ..< results.count {
            let CategoryModel = results[i]
            if let code = CategoryModel.code, let name = CategoryModel.name {
                categories.append(CategoryModel)
            }
        }
        return categories
    }
    
    // 카테고리 Dictionary 리턴
    @discardableResult func categoriesDict() -> [String: String] {
        let results = realm.objects(CategoryModel.self)
        var categories: [String: String] = [:]
        for i in 0 ..< results.count {
            let CategoryModel = results[i]
            if let code = CategoryModel.code, let name = CategoryModel.name {
                categories[code] = name
            }
        }
        return categories
    }
}
