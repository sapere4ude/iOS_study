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
    
    var infoData:JSON = JSON.null {
        didSet {
            DispatchQueue.main.async {
                self.shoppingTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shoppingTableView.delegate = self
        self.shoppingTableView.dataSource = self
        // dequeue를 사용하기 위해선 반드시 아래와 같은 등록 과정을 거쳐야 한다! 아래와 같이 하기 싫다면 스토리보드로 이동하여 직접 identifier에
        // 값을 지정하는 방법도 있긴하다.
        self.shoppingTableView.register(UINib(nibName: "ShoppingTableViewCellType1", bundle: nil), forCellReuseIdentifier: "ShoppingTableViewCellType1")
        self.shoppingTableView.register(UINib(nibName: "ShoppingTableViewCellType2", bundle: nil), forCellReuseIdentifier: "ShoppingTableViewCellType2")
        self.shoppingTableView.register(UINib(nibName: "ShoppingTableViewCellType3", bundle: nil), forCellReuseIdentifier: "ShoppingTableViewCellType3")
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        self.shoppingTableView.showsHorizontalScrollIndicator = false
//        self.shoppingTableView.showsVerticalScrollIndicator = false
    
        requestData(param: Dictionary(), completeHandler: { responseJson in
            self.infoData = responseJson
        }, failureHandler: { err in
            
        })
    }
    
    func requestData(param:[String:Any],completeHandler:@escaping (JSON) -> (), failureHandler: @escaping (Error) -> ()) { //이부분이 원래 REST API로 호출하는 부분. 써버가 없기때문에 json파일로 일단 박아놓고 쓰겠습니다. 이부분은 서버로 구현을 해야합니다.
        DispatchQueue.global().async {
            usleep(1 * 1000 * 1000)//뭔가 인터넷 통신을 하는것처럼 느끼기위해 슬립을 줌
            if let path = Bundle.main.path(forResource: "ExampleJson", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let testJson:JSON = try! JSON.init(data: data)
                    completeHandler(testJson)
                } catch {
                    // handle error
                }
            }
        }
    }
        
        
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {  // heightForRowAt : 행 간의 간격조절 역할
        let type = self.infoData[indexPath.row]["type"].intValue
        var returnValue:CGFloat = 0
        if type == 1 {  // "화장품 리스트를 보여드립니다!"
            returnValue = 200
        }
        else if type == 2 { // "여름에 잘 어울리는 화장품"
            var lineCnt:Int = self.infoData[indexPath.row]["value"].count/2     // indexPath.row에 JSON파일에서 넣은 값들이 존재
            if self.infoData[indexPath.row].count%2 == 1 {
                lineCnt += 1
            }
            returnValue = (UIScreen.main.bounds.width/2 - 15 + 10) * CGFloat(lineCnt) + 40
        }
        else if type == 3 { // 링크 주소
            returnValue = 50
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.infoData[indexPath.row]["type"].intValue
        let value:JSON = self.infoData[indexPath.row]["value"]
        if type == 1 {
            let cell:ShoppingTableViewCellType1 = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCellType1", for: indexPath) as! ShoppingTableViewCellType1
            cell.infoData = value
            cell.titleLabel.text = self.infoData[indexPath.row]["title"].stringValue
            return cell
        }
        else if type == 2 {
            let cell:ShoppingTableViewCellType3 = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCellType3", for: indexPath) as! ShoppingTableViewCellType3
            cell.infoData = value
            cell.titleLabel.text = self.infoData[indexPath.row]["title"].stringValue
            return cell
        }
//        else if type == 3 {
//            let cell:ShoppingTableViewCellType2 = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCellType2", for: indexPath) as! ShoppingTableViewCellType2
//            cell.infoData = value
//            return cell
//        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
