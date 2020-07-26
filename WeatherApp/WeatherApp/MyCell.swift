//
//  MyCell.swift
//  WeatherApp
//
//  Created by sapere4ude on 2020/07/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: Dictionary<String,Any>? = nil {
        didSet{
            self.titleLabel.text = data?["name"] as? String
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    
}
