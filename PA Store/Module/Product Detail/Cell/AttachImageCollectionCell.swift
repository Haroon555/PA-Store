//
//  AttachImageCollectionCell.swift
//  HomeMedics
//
//  Created by Haroon Shoukat on 02/02/2023.
//  Copyright © 2023 HomeMedics. All rights reserved.
//

import UIKit

class AttachImageCollectionCell: UICollectionViewCell {
    var buttonClick : (() -> ())? = {}

    @IBOutlet weak var imgAttach: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didDeleteBtnTap(_ sender: Any) {
        buttonClick!()
    }
    
    class func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> AttachImageCollectionCell {
        let cellIdentifier = "AttachImageCollectionCell"
        collectionView.register(UINib(nibName: "AttachImageCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AttachImageCollectionCell
        return cell
    }
}
