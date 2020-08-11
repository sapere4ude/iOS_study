//
//  HomeProduct.swift
//  Hwahae
//
//  Created by sapere4ude on 2020/08/07.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HomeProduct: UITableViewCell {

    @IBOutlet var HomeProductLeft: UIImageView!
    @IBOutlet var HomeProductCenter: UIImageView!
    @IBOutlet var HomeProductRight: UIImageView!
    
    @IBOutlet var HomeProductLeftName: UILabel!
    @IBOutlet var HomeProductCenterName: UILabel!
    @IBOutlet var HomeProductRightName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
