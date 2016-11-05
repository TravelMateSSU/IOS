//
//  EpilogueTimelineTableViewCell.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 11. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class EpilogueTimelineCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var epilogue: EpilogueModel! {
        willSet (setEpilogue) {
            if setEpilogue.images.count == 0 {
                height = collectionViewHeight.constant
                collectionViewHeight.constant = 0
            } else if height != 0 {
                collectionViewHeight.constant = height
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var height: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "EpilogueImageViewCell", bundle: nil), forCellWithReuseIdentifier: "EpilogueImageViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return epilogue.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpilogueImageViewCell", for: indexPath) as? EpilogueImageCell
        
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
