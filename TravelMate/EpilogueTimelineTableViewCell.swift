//
//  EpilogueTimelineTableViewCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class EpilogueTimelineTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var epilogue: EpilogueModel!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var decriptionLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var height: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "EpilogueImageViewCell", bundle: nil), forCellWithReuseIdentifier: "EpilogueImageViewCell")
        
        if epilogue.images.count == 0 {
            height = collectionViewHeight.constant
            collectionViewHeight.constant = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return epilogue.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpilogueImageViewCell", for: indexPath) as? EpilogueImageCollectionViewCell
        
        guard let epilogueCell = cell else {
            return UICollectionViewCell()
        }
        
        epilogueCell.layer.borderColor = UIColor.clear.cgColor
        epilogueCell.layer.borderWidth = 0
        epilogueCell.imageView.image = epilogue.images[indexPath.row]
        
        return epilogueCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
    }
}
