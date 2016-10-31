//
//  evaluationView.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 29..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

// 평가 뷰(별점)
class EvaluationView: UIView {
    
//    let starImage = UIImage(named: "star")!
//    let emptyStarImage = UIImage(named: "emptyStar")!

    var evaluationImageViews: [UIImageView]!
    
    var score = 0 {
        willSet {
            // 점수 = 별 개수
            // 점수에 따른 이미지 변화
            for i in 1...5 {
                if i < self.score {
//                    evaluationImageViews[i].image = starImage
                } else {
//                    evaluationImageViews[i].image = emptyStarImage
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let view = Bundle.main.loadNibNamed("EvaluationView", owner: self, options: nil)?.first as? UIView
        guard let evaluationView = view else {
            return
        }
        
        evaluationView.frame = bounds
        addSubview(evaluationView)
    }
    
    override func awakeFromNib() {
        // 평가 별 이미지 뷰를 배열화
//        evaluationImageViews.append(evaluationImageView1)
//        evaluationImageViews.append(evaluationImageView2)
//        evaluationImageViews.append(evaluationImageView3)
//        evaluationImageViews.append(evaluationImageView4)
//        evaluationImageViews.append(evaluationImageView5)
    }
}
