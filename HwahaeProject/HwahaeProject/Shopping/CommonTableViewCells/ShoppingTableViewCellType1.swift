//
//  ShoppingTableViewCellType1.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/11.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ShoppingTableViewCellType1: UITableViewCell {
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtnView: UIView!
    @IBOutlet weak var moreBtnImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
