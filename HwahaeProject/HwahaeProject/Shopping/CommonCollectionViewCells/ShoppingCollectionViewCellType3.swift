//
//  ShoppingCollectionViewCellType3.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/12.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ShoppingCollectionViewCellType3: UICollectionViewCell {
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgContainerView: UIView!
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }

    func initUI() {
        self.mainContainerView.backgroundColor = .white
        self.textContainerView.backgroundColor = .clear
        self.imgContainerView.backgroundColor = .clear
        self.imgContainerView.layer.borderWidth = 1
        self.imgContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.imgContainerView.layer.cornerRadius = 3
        
        self.titleLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        self.titleLabel.textColor = .darkGray
        
        self.introduceLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        self.introduceLabel.textColor = .gray
        
        self.imgContainerView.contentMode = .scaleToFill
    }
}
