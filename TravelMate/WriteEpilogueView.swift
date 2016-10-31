//
//  WriteEpilogueView.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 29..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol ImagePickDelegate {
    func imagePickPressed(imagePicker: UIImagePickerController)
}

// 후기 작성 뷰
class WriteEpilogueView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RemovableCellDelegate {
    
    var height: CGFloat?
    
    var epilogue: EpilogueModel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var delegate: ImagePickDelegate?
    
    @IBAction func insertImagePressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if let delegate = self.delegate {
            delegate.imagePickPressed(imagePicker: imagePicker)
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
    
    
    fileprivate func setup() {
        let view = loadFromXibName()
        guard let writeEpilogueView = view else {
            return
        }
        addSubview(writeEpilogueView)
        writeEpilogueView.frame = bounds
        epilogue = EpilogueModel()
    }
    
    @IBOutlet var imageCollectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        // 텍스트 뷰 top에서 부터 시작
        descriptionTextView.setContentOffset(.zero, animated: false)
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        height = imageCollectionViewHeight.constant
        imageCollectionViewHeight.constant = 0
        
        imageCollectionView.register(UINib(nibName: "WriteEpilogueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WriteEpilogueCollectionViewCell")
    }
    
    
    
    // CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return epilogue.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WriteEpilogueCollectionViewCell", for: indexPath) as? WriteEpilogueCollectionViewCell
        
        // Removable ImageView의 x버튼을 통해 이미지 삭제하기 위해
        // 각 셀마다 position값을 부여한 뒤 x를 누르면 position값 delegation
        cell?.position = indexPath.row
        
        guard let imageCell = cell else {
            return UICollectionViewCell()
        }
        
        imageCell.delegate = self
        if let imageData = Data(base64Encoded: epilogue.images[0].string) {
            imageCell.removableImageView.image = UIImage(data: imageData)
        }
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
        guard let pngData = UIImagePNGRepresentation(image) else {
            return
        }
        
        // epilogue.images에 추가
        epilogue.images.append(RealmString(value: [pngData.base64EncodedString()]))
        imageCollectionView.reloadData()
        
        if epilogue.images.count == 1 {
            if let height = self.height {
                imageCollectionViewHeight.constant = height
            }
        }
    }
    
    // 이미지 삭제 클릭
    func remove(position: Int) {
        // 해당 position의 이미지 삭제
        self.epilogue.images.remove(objectAtIndex: position)
        imageCollectionView.reloadData()
        
        if self.epilogue.images.isEmpty {
            imageCollectionViewHeight.constant = 0
        }
    }
}
