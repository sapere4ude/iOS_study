//
//  ViewController.swift
//  CloneIndicatorAndThread
//
//  Created by sapere4ude on 2020/07/20.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
    }
    
    // Action으로 만들게 되면 func 형태로 기본 틀을 제공받는다
    @IBAction func testAction(_ sender: Any) {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        DispatchQueue.main.async {
            for i in 0..<5 {
                usleep(1 * 1000 * 1000)
                print("\(i+1)")
            }
        }
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.indicator.isHidden = true
        }
    }
    

}


