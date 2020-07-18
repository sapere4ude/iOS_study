//
//  MyCell.swift
//  CloneTableView
//
//  Created by sapere4ude on 2020/07/13.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
