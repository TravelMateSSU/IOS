//
//  EpilogueModel.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 29..
//  Copyright © 2016년 이동규. All rights reserved.
//

import RealmSwift
import Foundation

class EpilogueModel: Object {
    dynamic var id = 0
    dynamic var text: String!
    let images = List<RealmString>()
}
