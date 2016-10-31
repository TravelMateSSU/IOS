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
    
    // 이미지
    let starImage = UIImage(named: "ic_star")!
    let emptyStarImage = UIImage(named: "ic_empty_star")!

    // 별점 이미지 뷰 -> 배열
    var evaluationImageViews: [UIImageView] = []
    
    // 별점 이미지 뷰들
    @IBOutlet var evaluationImageView1: UIImageView!
    @IBOutlet var evaluationImageView2: UIImageView!
    @IBOutlet var evaluationImageView3: UIImageView!
    @IBOutlet var evaluationImageView4: UIImageView!
    @IBOutlet var evaluationImageView5: UIImageView!
    
    // 별점 이미지 탭 제스차
    @IBOutlet var evaluationImageViewTapGesture1: UITapGestureRecognizer!
    @IBOutlet var evaluationImageViewTapGesture2: UITapGestureRecognizer!
    @IBOutlet var evaluationImageViewTapGesture3: UITapGestureRecognizer!
    @IBOutlet var evaluationImageViewTapGesture4: UITapGestureRecognizer!
    @IBOutlet var evaluationImageViewTapGesture5: UITapGestureRecognizer!
    
    
    @IBAction func evaluationImageView1Tapped(_ sender: UITapGestureRecognizer) {
        setImage(index: 1)
    }
    
    @IBAction func evaluationImageView2Tapped(_ sender: UITapGestureRecognizer) {
        setImage(index: 2)
    }
    
    @IBAction func evaluationImageView3Tapped(_ sender: UITapGestureRecognizer) {
        setImage(index: 3)
    }
    
    @IBAction func evaluationImageView4Tapped(_ sender: UITapGestureRecognizer) {
        setImage(index: 4)
    }
    
    @IBAction func evaluationImageView5Tapped(_ sender: UITapGestureRecognizer) {
        dump(sender.view)
        setImage(index: 5)
    }
    
    func setImage(index: Int) {
        for i in 0..<5 {
            if i < index {
                evaluationImageViews[i].image = starImage
            } else {
                evaluationImageViews[i].image = emptyStarImage
            }
        }
    }
    
    var score = 0 {
        willSet(score) {
            if score < 1 {
                self.score = 1
            }
            // 점수 = 별 개수
            // 점수에 따른 이미지 변화
            for i in 0..<5 {
                if i < self.score {
                    evaluationImageViews[i].image = starImage
                } else {
                    evaluationImageViews[i].image = emptyStarImage
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
        evaluationImageViews.append(evaluationImageView1)
        evaluationImageViews.append(evaluationImageView2)
        evaluationImageViews.append(evaluationImageView3)
        evaluationImageViews.append(evaluationImageView4)
        evaluationImageViews.append(evaluationImageView5)
        
        evaluationImageView1.addGestureRecognizer(evaluationImageViewTapGesture1)
        evaluationImageView2.addGestureRecognizer(evaluationImageViewTapGesture2)
        evaluationImageView3.addGestureRecognizer(evaluationImageViewTapGesture3)
        evaluationImageView4.addGestureRecognizer(evaluationImageViewTapGesture4)
        evaluationImageView5.addGestureRecognizer(evaluationImageViewTapGesture5)
    }
}
