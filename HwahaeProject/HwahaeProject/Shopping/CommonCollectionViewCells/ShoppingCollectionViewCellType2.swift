//
//  ShoppingCollectionViewCellType2.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/11.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShoppingCollectionViewCellType2: UICollectionViewCell {
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var isNewImgView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: property
    
    var infoData:JSON = JSON.null {
        didSet {
            self.titleLabel.text = infoData["title"].stringValue
            self.brandNameLabel.text = infoData["brand_name"].stringValue
            if infoData["is_brand_new"].intValue == 1 {
                isNewImgView.isHidden = true
            }
            self.mainImgView.contentMode = .scaleAspectFill
            self.mainImgView.sd_setImage(with:  URL(string: infoData["image_url"].stringValue), placeholderImage: nil, options: .lowPriority, completed: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initUI() {
        
    }
}
