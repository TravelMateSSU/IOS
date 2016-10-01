//
//  RouteView.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 9. 30..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class RouteView: UIView {
    
    let SMALL_SIZE = 20
    let MIDDLE_SIZE = 25
    let BIG_SIZE = 30
    
    var points: [[(x: Int, y: Int)]] = []
    
    var titles: [String] = []
    var ballNum: Int = 0
    
    
    override func layoutSubviews() {        // UIView의 Viewdidload
        if points.count == 0 {
            initBasePoints()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if points.count == 0 {
            initBasePoints()
        }
        for i in 0 ..< points[ballNum - 1].count {
            let point = points[ballNum - 1][i]
            let layer = CAShapeLayer()
            backgroundColor = UIColor.blue
            layer.path = UIBezierPath(roundedRect: CGRect(x: point.x - MIDDLE_SIZE >> 1, y: point.y - MIDDLE_SIZE >> 1, width: MIDDLE_SIZE, height: MIDDLE_SIZE), cornerRadius: 10).cgPath
            layer.fillColor = UIColor.red.cgColor
            self.layer.addSublayer(layer)
            
            
            if i > 0 {
                let lastPoint = points[ballNum - 1][i - 1]
                let dotPath = UIBezierPath()
                dotPath.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
                dotPath.addLine(to: CGPoint(x: point.x, y: point.y))
                dotPath.close()
                UIColor.red.set()
                dotPath.fill()
                dotPath.stroke()
            }
        }
        
        
        
    }
    
    func initBasePoints() {
        let screenWidth = Int(self.frame.size.width)
        let screenHeight = Int(self.frame.size.height)
        
        // 점 한 개
        points.append([(x: screenWidth >> 1, y: screenHeight >> 1)])
        
        // 점 두 개
        points.append([(x: (screenWidth / 3), y: screenHeight >> 1), (x: (screenWidth / 3) << 1, y: screenHeight >> 1)])
        
        // 점 세 개
        points.append([(x: screenWidth >> 2, y: screenHeight >> 1), (x: screenWidth >> 1, y: screenHeight >> 1), (x: screenWidth  - screenWidth >> 2, y: screenHeight >> 1)])
        
        // 점 네 개
        points.append([(x: screenWidth / 3, y: screenHeight / 3), (x: (screenWidth / 3) << 1, y: screenHeight / 3), (x: (screenWidth / 3) << 1, y: (screenHeight / 3) << 1), (x: screenWidth / 3, y: (screenHeight / 3) << 1)])
        
        // 점 다섯 개
        points.append([(x: screenWidth >> 2, y: screenHeight / 3), (x: screenWidth >> 1, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 2, y: screenHeight / 3), (x: (screenWidth / 3) << 1, y: (screenHeight / 3) << 1), (x: screenWidth / 3, y: (screenHeight / 3) << 1)])
        
        // 점 여섯 개
        points.append([(x: screenWidth >> 2, y: screenHeight / 3), (x: screenWidth >> 1, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 2, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 2, y: (screenHeight / 3) << 1), (x: screenWidth >> 1, y: (screenHeight / 3) << 1), (x: screenWidth >> 2, y: (screenHeight / 3) << 1)])
    }
    
    func append(title: String) {
        titles.append(title)
        ballNum += 1
    }
}
