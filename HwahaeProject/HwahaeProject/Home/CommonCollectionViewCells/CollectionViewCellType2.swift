//
//  CollectionViewCellType2.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class CollectionViewCellType2: UICollectionViewCell {

    //MARK: IBOutlet
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
            self.mainImgView.contentMode = .scaleToFill
            self.mainImgView.sd_setImage(with:  URL(string: infoData["image_url"].stringValue), placeholderImage: nil, options: .lowPriority, completed: nil)
        }
    }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: function
    
    func initUI() {
        
    }
    
    //MARK: action
    

}
