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
        print(resourcePath)
        print(dbPath)
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
                            let category = CategoryDto()
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
        let results = realm.objects(CategoryDto.self).filter(NSPredicate(format: "code = %@", categoryCode))
        if results.isEmpty{
            return "기타"
        }
        return results[0].name
    }
}
