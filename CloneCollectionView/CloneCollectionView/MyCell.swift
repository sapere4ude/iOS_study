//
//  MyCell.swift
//  CloneCollectionView
//
//  Created by sapere4ude on 2020/07/19.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var myImgView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImgView.contentMode = .scaleAspectFill
        self.myLabel.textColor = .white
    }
}
