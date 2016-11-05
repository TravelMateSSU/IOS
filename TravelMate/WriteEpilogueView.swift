//
//  WriteEpilogueView.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 29..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol ImagePickDelegate {
    func imagePickPressed()
}

// 후기 작성 뷰
class WriteEpilogueView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RemovableCellDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet var imageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet var descriptionPanGesture: UIPanGestureRecognizer!
    
    @IBOutlet var evaluationView: EvaluationView!
    
    var height: CGFloat?
    
    var epilogue: EpilogueModel!
    
    let imagePicker = UIImagePickerController()
    
    var delegate: ImagePickDelegate?
    
    var panY: CGFloat!
    
    @IBAction func insertImagePressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if let delegate = self.delegate {
            delegate.imagePickPressed()
        } else {
            print("Error! Please assign imageViewController in WriteEpilogueView")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            panY = sender.location(in: self).y
        } else {
            let curY = sender.location(in: self).y
            
            // 아래로 스와이프
            if panY < curY {
                let diffY = curY - panY
                
                // TODO: 스르륵 키보드 내려가기
                if diffY > 50 {
                    self.endEditing(true)
                }
            }
        }
    }
    
    fileprivate func setup() {
        let view = loadFromXibName()
        guard let writeEpilogueView = view else {
            return
        }
        addSubview(writeEpilogueView)
        writeEpilogueView.frame = bounds
        epilogue = EpilogueModel()
    }
    
    override func awakeFromNib() {
        // 텍스트 뷰 top에서 부터 시작
        descriptionTextView.setContentOffset(.zero, animated: false)
        
        imageCollectionView.register(UINib(nibName: "WriteEpilogueCell", bundle: nil), forCellWithReuseIdentifier: "WriteEpilogueCell")
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        height = imageCollectionViewHeight.constant
        imageCollectionViewHeight.constant = 0
        
        evaluationView.score = 0
        
        addGestureRecognizer(descriptionPanGesture)
    }
    
    
    
    // CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return epilogue.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WriteEpilogueCell", for: indexPath) as? WriteEpilogueCell
        
        guard let imageCell = cell else {
            return UICollectionViewCell()
        }
        
        // Removable ImageView의 x버튼을 통해 이미지 삭제하기 위해
        // 각 셀마다 position값을 부여한 뒤 x를 누르면 position값 delegation
        imageCell.delegate = self
        imageCell.position = indexPath.row
        
        imageCell.removableImageView.image = epilogue.images[indexPath.row]
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // cell's height = collectionView's height
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    
    // loadView
    func loadFromXibName() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WriteEpilogueView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view
    }
    
    // imagePicker
    func imagePick(image: UIImage) {
        // epilogue.images에 추가
        epilogue.images.append(image)
        DispatchQueue.main.async {
            self.imageCollectionView.reloadData()
        }
        
        if epilogue.images.count == 1 {
            if let height = self.height {
                imageCollectionViewHeight.constant = height
            }
        }
    }
    
    // 이미지 삭제 클릭
    func remove(position: Int) {
        // 해당 position의 이미지 삭제
        self.epilogue.images.remove(at: position)
        self.imageCollectionView.reloadData()
        
        if self.epilogue.images.isEmpty {
            imageCollectionViewHeight.constant = 0
        }
    }
}
