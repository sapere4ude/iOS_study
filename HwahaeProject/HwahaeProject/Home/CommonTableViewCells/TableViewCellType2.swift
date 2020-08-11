//
//  TableViewCellType2.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewCellType2: UITableViewCell {

    //MARK: IBOutlet
    
    //MARK: property
    
    var infoData:JSON = JSON.null {
           didSet {
               
           }
       }
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: function
    
    //MARK: action
    
    
}

