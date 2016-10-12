//
//  Error.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

enum APIError: Error {
    case DelegateNotFound
    case HttpResponseFailed
}
