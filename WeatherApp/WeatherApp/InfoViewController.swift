//
//  InfoViewController.swift
//  WeatherApp
//
//  Created by sapere4ude on 2020/07/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

// todo 구글지도로 마커찍기
class InfoViewController: UIViewController {
    
    //todo 디자인하기
    @IBOutlet weak var label: UILabel!
    
    var data: JSON = JSON.null {
        didSet {
            print("data: \(data)")
            print("test: \(data["main"]["temp_min"].intValue)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.label.text = String(converteKelvinToCelsius(input:
//            data["main"]["temp_min"].floatValue))
        self.label.text = "ㅋ.ㅋ"
    }
    
    func converteKelvinToCelsius(input: Float) -> Float {
        return input - 273.5
    }
}
