//
//  ShoppingTableViewCellType2.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/11.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShoppingTableViewCellType2: UITableViewCell {

    var infoData:JSON = JSON.null {
           didSet {
               
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
