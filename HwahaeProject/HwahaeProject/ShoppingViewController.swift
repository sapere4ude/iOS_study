//
//  ShoppingViewController.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var shoppingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shoppingTableView.delegate = self
        self.shoppingTableView.dataSource = self
        // dequeue를 사용하기 위해선 반드시 아래와 같은 등록 과정을 거쳐야 한다! 아래와 같이 하기 싫다면 스토리보드로 이동하여 직접 identifier에
        // 값을 지정하는 방법도 있긴하다.
        self.shoppingTableView.register(UINib(nibName: "ShoppingTableViewCellType1", bundle: nil), forCellReuseIdentifier: "ShoppingTableViewCellType1")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.shoppingTableView.showsHorizontalScrollIndicator = false
        self.shoppingTableView.showsVerticalScrollIndicator = false
    
    }
        
        
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultCnt = 5
        
        return resultCnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingTableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCellType1", for: indexPath) as! ShoppingTableViewCellType1
        
        return cell
    }
    

    
}
