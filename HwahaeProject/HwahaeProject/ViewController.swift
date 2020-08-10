//
//  ViewController.swift
//  HwahaeProject
//
//  Created by sapere4ude on 2020/08/10.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    //MARK: IBOutlet
        
        
    @IBOutlet weak var tableView: UITableView!
    
        //MARK: property
        
        var infoData:JSON = JSON.null {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        //MARK: lifeCycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            initUI()
            requestData(param: Dictionary(), completeHandler: { responseJson in
                self.infoData = responseJson
            }, failureHandler: { err in
                
            })
        }
        
        //MARK: function
        
        func initUI() {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            // dequeue를 사용하기 위해선 반드시 아래와 같은 등록 과정을 거쳐야 한다! 아래와 같이 하기 싫다면 스토리보드로 이동하여 직접 identifier에
            // 값을 지정하는 방법도 있긴하다.
            self.tableView.register(UINib(nibName: "TableViewCellType1", bundle: nil), forCellReuseIdentifier: "TableViewCellType1")
            self.tableView.register(UINib(nibName: "TableViewCellType2", bundle: nil), forCellReuseIdentifier: "TableViewCellType2")
            self.tableView.register(UINib(nibName: "TableViewCellType3", bundle: nil), forCellReuseIdentifier: "TableViewCellType3")
            self.tableView.separatorStyle = .none
        
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
        
        //MARK: action
        
        
        
    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
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
        
        // 섹션 하나에 들어갈 row의 개수를 정해주는 함수. infoData에서 받아오는 데이터의 수만큼 row의 개수가 유동적으로 변할 수 있게 해준다.
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.infoData.count
        }
        
        // IndexPath : tableView의 행을 식별하는 인덱스 경로
        // dequeue 사용하려면 반드시 nib 또는 class 등록을 해야한다. 또는 스토리보드에서 프로토타입 셀을 연결시켜야한다.
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let type = self.infoData[indexPath.row]["type"].intValue
            let value:JSON = self.infoData[indexPath.row]["value"]
            if type == 1 {
                let cell:TableViewCellType1 = tableView.dequeueReusableCell(withIdentifier: "TableViewCellType1", for: indexPath) as! TableViewCellType1
                cell.infoData = value
                cell.titleLabel.text = self.infoData[indexPath.row]["title"].stringValue
                return cell
            }
            else if type == 2 {
                let cell:TableViewCellType3 = tableView.dequeueReusableCell(withIdentifier: "TableViewCellType3", for: indexPath) as! TableViewCellType3
                cell.infoData = value
                cell.titleLabel.text = self.infoData[indexPath.row]["title"].stringValue
                return cell
            }
            else if type == 3 {
                let cell:TableViewCellType2 = tableView.dequeueReusableCell(withIdentifier: "TableViewCellType2", for: indexPath) as! TableViewCellType2
                cell.infoData = value
                return cell
            }
            else {
                return UITableViewCell()
            }
        }


        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }

}


