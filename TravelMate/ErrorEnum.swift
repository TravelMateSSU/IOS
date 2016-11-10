//
//  ErrorManager.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 10..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation


enum TourError {
    var errorMessage: String! {
        switch self {
        case .A:
            return "A"
        default:
            return "B"
        }
    }
    case A
    case B
}
