//
//  HomeViewController.swift
//  Hwahae
//
//  Created by sapere4ude on 2020/08/03.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // 제일 상단부
    @IBOutlet var btnMainView: UIBarButtonItem!
    @IBOutlet var serchProduct: UITextField!
    @IBOutlet var btnShoppingView: UIBarButtonItem!
    
    // 랭킹, 화해쇼핑, 카테고리검색, 성분으로 검색
    @IBOutlet var btnShowLanking: UIButton!
    @IBOutlet var btnShopping: UIButton!
    @IBOutlet var btnSearchCategory: UIButton!
    @IBOutlet var btnSearchIngredients: UIButton!
    
    // 브랜드별 제품 이미지
    @IBOutlet var productImgLeft: UIImageView!
    @IBOutlet var productImgCenter: UIImageView!
    @IBOutlet var productImgRight: UIImageView!
    
    // 브랜드 이름
    @IBOutlet var brandNameLeft: UILabel!
    @IBOutlet var brandNameCenter: UILabel!
    @IBOutlet var brandNameRight: UILabel!
    
    // 제품 이름
    @IBOutlet var productNameLeft: UILabel!
    @IBOutlet var productNameCenter: UILabel!
    @IBOutlet var productNameRight: UILabel!
    
    // 인기 신제품
    @IBOutlet var newProduct1: UIImageView!
    @IBOutlet var newProduct2: UIImageView!
    @IBOutlet var newProduct3: UIImageView!
    @IBOutlet var newProduct4: UIImageView!
    @IBOutlet var newProduct5: UIImageView!
    @IBOutlet var newProduct6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
