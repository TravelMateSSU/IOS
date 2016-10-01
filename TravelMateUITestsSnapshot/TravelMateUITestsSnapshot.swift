//
//  TravelMateUITestsSnapshot.swift
//  TravelMateUITestsSnapshot
//
//  Created by 이동규 on 2016. 10. 1..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest

class TravelMateUITestsSnapshot: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
//        XCUIApplication().launch()

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.tap()
        snapshot("1번 캡쳐")
        element.tap()
        snapshot("2번 캡쳐")
        element.tap()
        snapshot("3번 캡쳐")
    }
}
