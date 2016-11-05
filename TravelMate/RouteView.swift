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
    var titlePoints: [(x: Int, y: Int)] = []
    
    var spots: [SpotModel] = [] {
        willSet {
            ballNum = spots.count
        }
    }
    var ballNum: Int = 0
    var title: String?
    
    override func layoutSubviews() {        // UIView의 Viewdidload
        if points.count == 0 {
            initBasePoints()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if points.count == 0 {
            initBasePoints()
        }
        if ballNum <= 0 {
            ballNum = 1
        }
        
        for i in 0 ..< points[ballNum - 1].count {
            let point = points[ballNum - 1][i]
            
            /// 여행 경로 꼭짓점 그리기
            let layer = CAShapeLayer()
            layer.path = UIBezierPath(roundedRect: CGRect(x: point.x - MIDDLE_SIZE >> 1, y: point.y - MIDDLE_SIZE >> 1, width: MIDDLE_SIZE, height: MIDDLE_SIZE), cornerRadius: 10).cgPath
            layer.fillColor = UIColor.red.cgColor
            self.layer.addSublayer(layer)
            
            /// 여행 경로 관광지 이름 label
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = spots[i].title
            titleLabel.sizeToFit()
            titleLabel.frame.size.width = CGFloat(Int(self.frame.size.width) >> 2)
            titleLabel.tintColor = UIColor.black
            if ballNum < 4 {
                titleLabel.center = CGPoint(x: point.x, y: point.y + MIDDLE_SIZE + 10)
            } else {
                if i < (ballNum >> 1) + ballNum % 2 {
                    titleLabel.center = CGPoint(x: point.x, y: point.y - MIDDLE_SIZE - 10)
                } else {
                    titleLabel.center = CGPoint(x: point.x, y: point.y + MIDDLE_SIZE + 10)
                }
            }
            self.addSubview(titleLabel)
            
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
        
        // titlePoints = 경로 자체의 타이틀을 넣을 수 있음(보류)
        
        
        // 점 한 개
        points.append([(x: screenWidth >> 1, y: screenHeight >> 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 2 * 3))
        
        // 점 두 개
        points.append([(x: (screenWidth >> 2), y: screenHeight >> 1), (x: (screenWidth >> 2) * 3, y: screenHeight >> 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 2 * 3))
        
        // 점 세 개
        points.append([(x: screenWidth >> 3, y: screenHeight >> 1), (x: screenWidth >> 1, y: screenHeight >> 1), (x: screenWidth  - screenWidth >> 3, y: screenHeight >> 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 2 * 3))
        
        // 점 네 개
        points.append([(x: screenWidth >> 2, y: screenHeight / 3), (x: (screenWidth >> 2) * 3, y: screenHeight / 3), (x: (screenWidth >> 2) * 3, y: (screenHeight / 3) << 1), (x: screenWidth >> 2, y: (screenHeight / 3) << 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 1))
        
        // 점 다섯 개
        points.append([(x: screenWidth >> 3, y: screenHeight / 3), (x: screenWidth >> 1, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 3, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 3, (y: screenHeight / 3) << 1), (x: screenWidth >> 3, y: (screenHeight / 3) << 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 1))
        
        // 점 여섯 개
        points.append([(x: screenWidth >> 3, y: screenHeight / 3), (x: screenWidth >> 1, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 3, y: screenHeight / 3), (x: screenWidth  - screenWidth >> 3, y: (screenHeight / 3) << 1), (x: screenWidth >> 1, y: (screenHeight / 3) << 1), (x: screenWidth >> 3, y: (screenHeight / 3) << 1)])
//        titlePoints.append((x: screenWidth >> 1, y: screenHeight >> 1))
    }
    
    func append(spot: SpotModel) {
        spots.append(spot)
        ballNum += 1
    }
}
