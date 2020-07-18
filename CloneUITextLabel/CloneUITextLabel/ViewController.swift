//
//  ViewController.swift
//  CloneUITextLabel
//
//  Created by sapere4ude on 2020/07/11.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = "안녕하세요"
        label1.font = UIFont(name: "HelveticaNenue-BoldItalic", size: 20)
        label1.textColor = .brown
        let sumAttString = NSMutableAttributedString(string: "hello world", attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-BoldItalic", size: 12) as Any, NSAttributedString.Key.foregroundColor : UIColor.blue])
        sumAttString.addAttributedStringInSpecificString(targetString: "hello", attr: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-UltraLight", size: 12) as Any, NSAttributedString.Key.foregroundColor : UIColor.red])
        label2.attributedText = sumAttString
    }
}

extension NSMutableAttributedString{    // NSMutableAttributedString 함수안에 새로운 함수를 추가해주는 작업
    func addAttributedStringInSpecificString(targetString: String, attr: [NSMutableAttributedString.Key : Any]){
        let range = (self.string as NSString).range(of: targetString)
        self.addAttributes(attr, range: range)
    }
}

